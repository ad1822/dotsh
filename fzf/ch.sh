#!/usr/bin/env bash

languages=$(echo "golang bash c cpp javascript typescript lua python" | tr ' ' '\n')
core_utils=$(echo "xargs find mv sed awk" | tr ' ' '\n')
extras=$(echo "git docker http regex" | tr ' ' '\n')

selected=$(printf "%s\n%s\n%s\n" "$languages" "$core_utils" "$extras" |
  fzf --ansi --style=full --prompt="Cheat> " --header="Select language, command, or topic")

read -p "Query: " query

style="rrt"

query=$(echo "$query" | tr ' ' '+')

if printf '%s\n' "$languages" | grep -qs "^$selected$"; then
  endpoint="$selected/$query"
else
  endpoint="$selected~$query"
fi

tmux neww bash -c "
  curl -s cht.sh/$endpoint?style=$style | less -R
"
