#!/usr/bin/env bash

home="/home/$(whoami)"

loop() {
  for dir in $(ls ${home}); do
    if [[ -f "$dir" ]]; then
      echo "$dir"
    else
      echo "do"
    fi
  done
}

loop
