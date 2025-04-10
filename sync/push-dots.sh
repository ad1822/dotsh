#!/bin/bash

cat <<'EOF' | lolcat
   * *
*   * *
 **    **

  *     *
       *
 *   *

      *
*
   *
EOF


cd ~/hyprdots || exit

if git status --porcelain | grep -q " M "; then
    changes=$(git status --porcelain | awk '$1 == "M" || $1 == " M" {print $2}' | awk -F'/' '{print $1}' | sort -u )

    if [ -z "$changes" ]; then
        commit_msg="changes: no tracked modifications"
    else
        commit_msg="changes: $changes"
    fi

    eval "$(ssh-agent -s)" > /dev/null
    OUTPUT=$(ssh-add ~/.ssh/github 2>&1)

    if [[ $OUTPUT =~ Identity\ added:\ .*\((.*)\) ]]; then
      EMAIL=${BASH_REMATCH[1]}
      echo -e "\e[1;32m ✔ Identity added for:\e[0m \e[1;33m$EMAIL\e[0m"
    else
      echo -e "\e[1;31m✖ Failed to add identity\e[0m"
      echo -e "\e[0;90m$OUTPUT\e[0m"
    fi

    echo -e "\n\e[1;36m 📦 Git status:\e[0m"
    git ss
    git add .
    git commit -m "$commit_msg"
    PUSH_OUTPUT=$(git push origin main)

    echo -e "\n\e[1;36m$PUSH_OUTPUT\e[0m"

    echo -e "\e[1;32m ✔ Changes committed and pushed: $commit_msg\e[0m."
else
    echo "No changes to commit."
fi
