#!/bin/bash
cat <<'EOF'
   __                       _ ____
  / /_____ ___  __  ___  __(_) __/_  __
 / __/ __ `__ \/ / / / |/_/ / /_/ / / /
/ /_/ / / / / / /_/ />  </ / __/ /_/ /
\__/_/ /_/ /_/\__,_/_/|_/_/_/  \__, /
                              /____/
EOF

SESSION=$1
PROJECT_DIR=$2

nohup kitty bash -c "

tmux has-session -t $SESSION 2>/dev/null

if [ \$? != 0 ]; then
  tmux new-session -d -s $SESSION -n 'main' -c $PROJECT_DIR

  tmux new-window -t $SESSION:1 -n 'worker1' -c $PROJECT_DIR
  tmux new-window -t $SESSION:2 -n 'worker2' -c $PROJECT_DIR
  tmux new-window -t $SESSION:3 -n 'logs' -c $PROJECT_DIR
fi

tmux select-window -t $SESSION:1
tmux attach-session -t $SESSION
" >/dev/null 2>&1 &
