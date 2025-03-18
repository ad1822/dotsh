#!/bin/bash

cd ~/hyprdots || exit

if git status --porcelain | grep -q " M "; then
    changes=$(git status --porcelain | grep " M " | awk '{print $2}' | awk -F'/' '{print $1}' | sort -u | tr '\n' ', ')

    changes=${changes%  }

    commit_msg="Changes in: $changes"
    echo $commit_msg

    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/github

    git s5
    git add .
    git commit -m "$commit_msg"
    git push origin main

    echo "Changes committed and pushed: $commit_msg"
else
    echo "No changes to commit."
fi
