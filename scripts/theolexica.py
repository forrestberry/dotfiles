#!/usr/bin/env python3
import subprocess
import sys
import re
import shlex
import argparse
import logging
from pathlib import Path

def run_command(cmd_list, cwd=None, capture_output=False, shell=False):
    """Run a shell command in a specific directory."""
    try:
        result = subprocess.run(
            cmd_list,
            check=True,
            cwd=cwd,
            stdout=subprocess.PIPE if capture_output else None,
            stderr=subprocess.PIPE if capture_output else None,
            text=True,
            shell=shell
        )
        if capture_output:
            return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        logging.error(f"Error running command: {' '.join(cmd_list)}\n{e.stderr}")
        sys.exit(1)

def static_file_paths_and_links(directory, dry_run=False):
    """Find and replace static file paths and links in markdown files."""
    logging.info("Fixing static file paths and links in markdown files...")

    md_files = list(Path(directory).rglob('*.md'))

    # Compile regex patterns
    static_file_pattern = re.compile(r'(!?)\[([^\]]*)\]\(?\/?static/([^\)]+)\)?')
    markdown_link_pattern = re.compile(r'(?<!\!)\[([^\]]+)\]\(((?!{{< ref)[^\)]+\.md)\)')
    wikilink_pattern = re.compile(r'\[\[([^\]]+)\]\]')

    for filepath in md_files:
        with open(filepath, 'r', encoding='utf-8') as file:
            content = file.read()

        original_content = content

        # Replace static file paths
        content = static_file_pattern.sub(r'\1[\2](/\3)', content)

        # Replace markdown links with Hugo ref shortcode, excluding static files and already processed links
        content = markdown_link_pattern.sub(r'[\1]({{< ref "\2" >}})', content)

        # Replace wikilinks with Hugo ref shortcode
        content = wikilink_pattern.sub(r'[\1]({{< ref "\1" >}})', content)

        if content != original_content:
            if dry_run:
                logging.info(f"Dry run: Would update {filepath}")
            else:
                with open(filepath, 'w', encoding='utf-8') as file:
                    file.write(content)
                logging.info(f"Updated {filepath}")

def generate_commit_message(git_diff, llm_model, dry_run=False):
    """Generate a commit message using an LLM based on the git diff."""
    llm_prompt = "Generate a git commit message based on the diff above. Be very concise. Do not include markdown formatting or code blocks. Include the name of the documents that were changed."

    llm_command = ['llm', llm_prompt, '--no-stream', '-m', llm_model]

    if dry_run:
        logging.info('Dry run: ' + ' '.join(llm_command))
        return 'Generated commit message (dry run)'
    else:
        try:
            result = subprocess.run(
                llm_command,
                input=git_diff,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
            )
            if result.returncode != 0:
                raise subprocess.CalledProcessError(result.returncode, llm_command, output=result.stdout, stderr=result.stderr)
            commit_message = result.stdout.strip()
            # Strip triple backticks if present
            if commit_message.startswith('```') and commit_message.endswith('```'):
                commit_message = commit_message[3:-3].strip()
            return commit_message
        except subprocess.CalledProcessError as e:
            logging.error(f"Error generating commit message: {e.stderr}")
            return input("Enter your commit message: ")

def main():
    parser = argparse.ArgumentParser(description='Sync notes to theolexica repository and process markdown files.')
    parser.add_argument('--notes-dir', default='/Users/forrest/Documents/notes/public/', help='Path to the notes directory')
    parser.add_argument('--repo-dir', default='/Users/forrest/code/theolexica', help='Path to the theolexica repository')
    parser.add_argument('--llm-model', default='gpt-4o-mini', help='LLM model to use for generating commit messages')
    parser.add_argument('--dry-run', action='store_true', help='Perform a dry run without making any changes')
    args = parser.parse_args()

    # Set up logging
    logging.basicConfig(level=logging.INFO, format='%(message)s')

    notes_dir = Path(args.notes_dir)
    repo_dir = Path(args.repo_dir)
    llm_model = args.llm_model
    dry_run = args.dry_run

    # Define paths
    posts_src = notes_dir
    posts_dest = repo_dir / 'content' / 'posts'

    static_src = notes_dir / 'static'
    static_dest = repo_dir / 'static'

    # Step 1: Run rsync command for posts
    logging.info("Running rsync for posts...")
    rsync_command = [
        'rsync', '-av', '--delete', '--exclude=static/', str(posts_src) + '/', str(posts_dest) + '/'
    ]
    if dry_run:
        logging.info('Dry run: ' + ' '.join(rsync_command))
    else:
        run_command(rsync_command)

    # Step 1.1: Run rsync command for static files
    logging.info("Running rsync for static files...")
    rsync_static_command = [
        'rsync', '-av', '--delete', str(static_src) + '/', str(static_dest) + '/'
    ]
    if dry_run:
        logging.info('Dry run: ' + ' '.join(rsync_static_command))
    else:
        run_command(rsync_static_command)

    # Step 2: Fix static file paths and links in markdown files
    static_file_paths_and_links(posts_dest, dry_run)

    # Step 3: git add . in the repository directory
    logging.info("Staging changes with git add .")
    if dry_run:
        logging.info('Dry run: git add .')
    else:
        run_command(['git', 'add', '.'], cwd=repo_dir)

    # Step 4: Get git diff and generate commit message using llm
    logging.info("Generating commit message using llm...")
    git_diff = run_command(['git', 'diff', '--cached'], cwd=repo_dir, capture_output=True)

    # Check if there are changes to commit
    if not git_diff.strip():
        logging.info("No changes to commit.")
        sys.exit(0)

    # Generate commit message using llm
    commit_message = generate_commit_message(git_diff, llm_model, dry_run)

    # Step 5: Prompt before committing
    logging.info("\nProposed commit message:")
    logging.info("-" * 40)
    logging.info(commit_message)
    logging.info("-" * 40)

    while True:
        confirm = input("\nDo you want to proceed with the commit? (y/n/a): ").strip().lower()
        if confirm == 'y':
            break
        elif confirm == 'n':
            commit_message = input("Enter your commit message: ")
            break
        elif confirm == 'a':
            logging.info("Aborted git commit. Changes are staged and visible in local host.")
            sys.exit(1)
        else:
            logging.info("Invalid input. Please enter 'y', 'n', or 'a'.")

    # Step 6: git commit and git push in the repository directory
    logging.info("Committing changes...")
    if dry_run:
        logging.info('Dry run: git commit -m "%s"', commit_message)
    else:
        run_command(['git', 'commit', '-m', commit_message], cwd=repo_dir)

        logging.info("Pushing to remote repository...")
        try:
            run_command(['git', 'push'], cwd=repo_dir)
            logging.info("Operation completed successfully.")
        except subprocess.CalledProcessError:
            logging.error("Error pushing commit. All changes committed. Try to push later.")

if __name__ == "__main__":
    main()

