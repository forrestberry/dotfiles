#!/usr/bin/env python3
import subprocess
import sys
import os
import re
import shlex

notes = "/Users/forrest/Documents/notes/public/"
theolexica = "/Users/forrest/code/theolexica/content/posts"

static = "/Users/forrest/Documents/notes/public/static/"
theolexica_static= "/Users/forrest/code/theolexica/static"

theolexica_repo = "/Users/forrest/code/theolexica"

def run_command(cmd, cwd=None, capture_output=False):
    """Run a shell command in a specific directory."""
    try:
        if capture_output:
            result = subprocess.run(
                cmd,
                shell=True,
                check=True,
                cwd=cwd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
            )
            return result.stdout.strip()
        else:
            subprocess.run(cmd, shell=True, check=True, cwd=cwd)
    except subprocess.CalledProcessError as e:
        print(f"Error running command: {cmd}\n{e.stderr}")
        sys.exit(1)

def static_file_paths_and_links(directory):
    """Find and replace static file paths and links in markdown files."""
    print("Fixing static file paths and links in markdown files...")
    for root, dirs, files in os.walk(directory):
        for filename in files:
            if filename.endswith('.md'):
                filepath = os.path.join(root, filename)
                with open(filepath, 'r', encoding='utf-8') as file:
                    content = file.read()

                original_content = content

                # Replace static file paths
                content = re.sub(
                    r'(!?)\[([^\]]*)\]\(?\/?static/([^\)]+)\)?',
                    r'\1[\2](/\3)',
                    content,
                )

                # Replace markdown links with Hugo ref shortcode, excluding static files and already processed links
                # From [link_text](link_target.md) to [link_text]({{< ref "link_target.md" >}})
                # Exclude static files using negative lookbehind and links already containing '{{< ref'
                content = re.sub(
                    r'(?<!\!)\[([^\]]+)\]\(((?!{{< ref)[^\)]+\.md)\)',
                    r'[\1]({{< ref "\2" >}})',
                    content,
                )

                # Replace wikilinks with Hugo ref shortcode
                # From [[link_target]] to [link_target]({{< ref "link_target" >}})
                content = re.sub(
                    r'\[\[([^\]]+)\]\]',
                    r'[\1]({{< ref "\1" >}})',
                    content,
                )

                if content != original_content:
                    with open(filepath, 'w', encoding='utf-8') as file:
                        file.write(content)
                    print(f"Updated {filepath}")

def main():
    repo_dir = theolexica_repo

    # Step 1: Run rsync command for posts
    rsync_command = f"rsync -av --delete --exclude='static/' '{notes}' '{theolexica}'"
    print("Running rsync posts...")
    run_command(rsync_command)

    # Step 1.1: Run rsync command for static files
    rsync_command = f"rsync -av --delete '{static}' '{theolexica_static}'"
    print("Running rsync static files...")
    run_command(rsync_command)

    # Step 2: Fix static file paths and links in markdown files
    static_file_paths_and_links(theolexica)

    # Step 3: git add . in the repository directory
    print("Staging changes with git add .")
    run_command("git add .", cwd=repo_dir)

    # Step 4: Get git diff and generate commit message using llm
    print("Generating commit message using llm...")
    git_diff = run_command("git diff --cached", cwd=repo_dir, capture_output=True)

    # Check if there are changes to commit
    if not git_diff.strip():
        print("No changes to commit.")
        sys.exit(0)

    # Prepare the git diff for the llm tool
    escaped_diff = git_diff.replace('"', '\\"').replace('$', '\\$').replace('`', '\\`')
    llm_command = (
        f'echo "{escaped_diff}" | llm "Generate a git commit message based on the diff above. Be concise and do not include markdown formatting or code blocks." --no-stream -m gpt-4o-mini'
    )
    try:
        commit_message = run_command(llm_command, capture_output=True)

        # Strip triple backticks if present
        commit_message = commit_message.strip()
        if commit_message.startswith('```') and commit_message.endswith('```'):
            commit_message = commit_message[3:-3].strip()

        # Step 5: Prompt before committing
        print("\nProposed commit message:")
        print("-" * 40)
        print(commit_message)
        print("-" * 40)
        confirm = input("\nDo you want to proceed with the commit? (y/n/a): ").strip().lower()
        if confirm == 'n':
            commit_message = input("Enter your commit message: ")
        elif confirm != 'y':
            print("Aborted git commit. Changes are staged and visible in local host.")
            sys.exit(1)
    except:
        print("Error generating commit message.")
        commit_message = input("Enter your commit message: ")

    # Step 6: git commit and git push in the repository directory
    print("Committing changes...")
    safe_commit_message = shlex.quote(commit_message)
    commit_command = f'git commit -m {safe_commit_message}'
    run_command(commit_command, cwd=repo_dir)

    print("Pushing to remote repository...")
    try: 
        run_command("git push", cwd=repo_dir)
        print("Operation completed successfully.")
    except:
        print("Error pushing commit. All changes commited. Try to push later.")


if __name__ == "__main__":
    main()

