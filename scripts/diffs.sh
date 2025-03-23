#!/usr/bin/env bash

# Exit on error
set -e

# Check for correct arguments
if [ $# -ne 3 ]; then
    echo "Usage: $0 <base_branch> <merged_branch> <folder>"
    exit 1
fi

BASE_BRANCH=$1
MERGED_BRANCH=$2
FOLDER=$3

# Ensure we have the latest changes from remote
echo "Fetching latest changes from remote..."
git fetch --quiet

# Find the merge commit - this will be the most recent merge from MERGED_BRANCH into BASE_BRANCH
MERGE_COMMIT=$(git log --merges --format="%H" -n 1 "$BASE_BRANCH" --grep="Merge pull request" --grep="from $MERGED_BRANCH")

if [ -z "$MERGE_COMMIT" ]; then
    echo "Error: Could not find merge commit from $MERGED_BRANCH into $BASE_BRANCH"
    exit 1
fi

echo "Found merge commit: $MERGE_COMMIT"

# Get the first parent (BASE_BRANCH before merge) and second parent (MERGED_BRANCH tip)
PARENT1=$(git log -n 1 --pretty=format:"%P" "$MERGE_COMMIT" | cut -d " " -f1)
PARENT2=$(git log -n 1 --pretty=format:"%P" "$MERGE_COMMIT" | cut -d " " -f2)

echo "Base branch state (parent1): $PARENT1"
echo "Merged branch tip (parent2): $PARENT2"

# Get all files changed in the merge
echo "Finding changes introduced by the PR..."
CHANGED_FILES=$(git diff --name-only "$PARENT1" "$MERGE_COMMIT" --)

if [ -z "$CHANGED_FILES" ]; then
    echo "No files changed in this PR."
    exit 0
fi

# Filter for specific file patterns in the specified folder
FILES=$(echo "$CHANGED_FILES" | grep -E "$FOLDER/.*/compose\.yml" || echo "")
if [ -n "$FILES" ]; then
    echo -e "\nChanged Docker Compose files:"
    echo "$FILES"
fi

# Output the FILES variable in GitHub Actions format
# Convert newlines to comma-separated string for GitHub Actions
FILES_CSV=$(echo "$FILES" | tr '\n' ',' | sed 's/,$//')
echo "changed_files=$FILES_CSV" >>"$GITHUB_OUTPUT"
