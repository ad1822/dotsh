#!/usr/bin/env bash

pushd ~/.config
selected_config=$(ls | fzf --style=full)

pushd $selected_config
nvim
