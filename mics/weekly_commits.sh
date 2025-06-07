#!/bin/bash

# ---------------------
# CONFIGURE THESE:

# Get current date and date 7 days ago in ISO 8601 format
NOW=$(date -Iseconds)
WEEK_AGO=$(date -Iseconds -d "-7 days")

echo "Fetching commits from $WEEK_AGO to $NOW for user: $GITHUB_USERNAME"
echo ""

# Get user repos
repos=$(curl -s -H "Authorization: token $GITHUB_PAT" \
"https://api.github.com/users/$GITHUB_USERNAME/repos?per_page=100" | jq -r '.[].full_name')

for repo in $repos; do
    # Get commits for the last 7 days
    commit_count=$(curl -s -H "Authorization: token $GITHUB_PAT" \
        "https://api.github.com/repos/$repo/commits?author=$GITHUB_USERNAME&since=$WEEK_AGO&until=$NOW" \
    | jq length)
    
    if [ "$commit_count" -gt 0 ]; then
        echo "$repo: $commit_count commits"
    fi
done
