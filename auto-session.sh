#!/bin/bash

kitty bash -c "
# Create new tmux session with first window in DevOps/lab
tmux new-session -d -s Kubernetes -n 'main' -c ~/DevOps/lab

# Create 3 additional windows
tmux new-window -t Kubernetes:2 -n 'worker1' -c ~/DevOps/lab
tmux new-window -t Kubernetes:3 -n 'worker2' -c ~/DevOps/lab
tmux new-window -t Kubernetes:4 -n 'logs' -c ~/DevOps/lab

# Return to first window and attach session
tmux select-window -t Kubernetes:1
tmux attach-session -t Kubernetes
"