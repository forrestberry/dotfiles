#!/usr/bin/env python3
import subprocess
import sys
import os

notes = "/Users/forrest/Documents/notes/public/"
theolexica = "/Users/forrest/code/theolexica/content/posts"
theolexica_repo = "/Users/forrest/code/theolexica"

def run_command(cmd, cwd=None, capture_output=False):
    """Run a shell command in a specific directory."""
    try:
        if capture_output:
            result = subprocess.run(cmd, shell=True, check=True, cwd=cwd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
            return result.stdout.strip()
        else:
            subprocess.run(cmd, shell=True, check=True, cwd=cwd)
    except subprocess.CalledProcessError as e:
        print(f"Error running command: {cmd}\n{e.stderr}")
        sys.exit(1)

def main():
    repo_dir = theolexica_repo

    # Step 1: Run rsync command
    rsync_command = f"rsync -av --delete '{notes}' '{theolexica}'"
    print("Running rsync...")
    run_command(rsync_command)

    # Step 2: git add . in the repository directory
    print("Staging changes with git add .")
    run_command("git add .", cwd=repo_dir)

    # Step 3: Get git diff and generate commit message using llm
    print("Generating commit message using llm...")
    git_diff = run_command("git diff --cached", cwd=repo_dir, capture_output=True)

    # Check if there are changes to commit
    if not git_diff.strip():
        print("No changes to commit.")
        sys.exit(0)

    # Prepare the git diff for the llm tool
    escaped_diff = git_diff.replace('"', '\\"').replace('$', '\\$').replace('`', '\\`')
    llm_command = f'echo "{escaped_diff}" | llm "Generate a git commit message based on the diff above. Be concise." --no-stream -m gpt-4o-mini'
    llm_command.replace('```', '')
    commit_message = run_command(llm_command, capture_output=True)

    # Step 4: Prompt before committing
    print("\nProposed commit message:")
    print("-" * 40)
    print(commit_message)
    print("-" * 40)
    confirm = input("\nDo you want to proceed with the commit? (y/n): ").strip().lower()
    if confirm != 'y':
        commit_message = input("Enter your commit message: ")

    # Step 5: git commit and git push in the repository directory
    print("Committing changes...")
    commit_command = f'git commit -m "{commit_message}"'
    run_command(commit_command, cwd=repo_dir)
    print("Pushing to remote repository...")
    run_command("git push", cwd=repo_dir)

    print("Operation completed successfully.")

if __name__ == "__main__":
    main()


