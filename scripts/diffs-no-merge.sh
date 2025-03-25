#!/usr/bin/env bash

# Exit on error
set -e

# Check if there are 2 arguments
if [ $# -ne 3 ]; then
    echo "Usage: $0 <base_branch> <head_branch> <folder>"
    exit 1
fi

BASE_BRANCH=$1
HEAD_BRANCH=$2
FOLDER=$3

# Ensure we have the latest changes from remote
echo "Fetching latest changes from remote..."
git fetch --quiet

# Validate that the branches exist
if ! git show-ref --verify --quiet refs/heads/"$BASE_BRANCH" && ! git show-ref --verify --quiet refs/remotes/origin/"$BASE_BRANCH"; then
    echo "Error: Base branch '$BASE_BRANCH' does not exist locally or remotely."
    exit 1
fi

if ! git show-ref --verify --quiet refs/heads/"$HEAD_BRANCH" && ! git show-ref --verify --quiet refs/remotes/origin/"$HEAD_BRANCH"; then
    echo "Error: Head branch '$HEAD_BRANCH' does not exist locally or remotely."
    exit 1
fi

# Determine the full refs
BASE_REF=$(git show-ref --verify refs/heads/"$BASE_BRANCH" 2>/dev/null || git show-ref --verify refs/remotes/origin/"$BASE_BRANCH")
BASE_REF=${BASE_REF%% *} # Extract just the SHA

HEAD_REF=$(git show-ref --verify refs/heads/"$HEAD_BRANCH" 2>/dev/null || git show-ref --verify refs/remotes/origin/"$HEAD_BRANCH")
HEAD_REF=${HEAD_REF%% *} # Extract just the SHA

echo "Finding changes between $BASE_BRANCH ($BASE_REF) and $HEAD_BRANCH ($HEAD_REF)..."

# Get changed files between the two branches
CHANGED_FILES=$(git diff --name-only "$BASE_REF" "$HEAD_REF" --)

if [ -z "$CHANGED_FILES" ]; then
    echo "No files changed between these branches."
    exit 0
fi

# Optional: Filter for specific file patterns
# Uncomment and modify as needed
FILES=$(echo "$CHANGED_FILES" | grep -E "$FOLDER/.*/compose\.yml" || echo "")
if [ -n "$FILES" ]; then
    echo -e "\nChanged Docker Compose files:"
    echo "$FILES"
fi

# Output the FILES variable in GitHub Actions format
# Convert newlines to comma-separated string for GitHub Actions
FILES_CSV=$(echo "$FILES" | tr '\n' ',' | sed 's/,$//')
echo "changed_files=$FILES_CSV" >>"$GITHUB_OUTPUT"
