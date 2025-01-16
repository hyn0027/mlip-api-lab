#!/bin/zsh

# Start a new tmux session
SESSION_NAME="MLIP-Lab1"
tmux new-session -d -s $SESSION_NAME

tmux send-keys -t $SESSION_NAME "source set_credentials.sh" C-m
tmux send-keys -t $SESSION_NAME "python app.py" C-m

sleep 1

tmux split-window -h -t $SESSION_NAME
tmux send-keys -t $SESSION_NAME "curl -X GET http://localhost:3000/api/v1/analysis/ \\
-H 'Content-Type: application/json' \\
-d '{\"uri\":\"http://jeroen.github.io/images/testocr.png\"}'" C-m

tmux send-keys -t $SESSION_NAME "curl -X GET http://localhost:3000/api/v1/analysis/ \\
-H 'Content-Type: application/json' \\
-d '{\"uri\":\"https://www.mattmahoney.net/ocr/stock_gs200.jpg\"}'" C-m

# wait until the previous command is done

sleep 5

tmux send-keys -t $SESSION_NAME:0.0 C-c


tmux attach-session -t $SESSION_NAME