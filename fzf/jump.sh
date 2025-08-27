#!/bin/bash

selectedfiles=$(
  fd --type f --hidden --max-depth 2 . ~/ |
    fzf --height=100% -m --border \
      --preview="bat --color=always {}" \
      --preview-window=right:50%
)
[ -z "$selectedfiles" ] && exit 0

if [[ ${#selectedfiles[@]} -eq 0 ]]; then
  exit 0
fi
IFS='
'
echo $selectedfiles
set -- $selectedfiles
nvim "$@"
# nvim "${selectedfiles[@]}"
