#!/bin/sh
tmux new-session -d -s gg -n bash
tmux new-window -n main
tmux select-window -t gg:main
tmux send-keys 'cd $HOME/workspace/senior-design/golf-glove/' Enter
# tmux new-window -d -a -t gg:bash -n servers
tmux new-window -d -n servers
tmux select-window -t gg:servers
tmux send-keys 'cd $HOME/workspace/senior-design/golf-glove/coachApp/backend/' Enter
# tmux split-window -t gg:servers -v
tmux split-window -v
tmux send-keys 'cd $HOME/workspace/senior-design/golf-glove/coachApp/frontend/' Enter
# tmux split-window -h 'go-golff'
# tmux new-window -d 'go-golf'

tmux new-window -d -n data
tmux select-window -t gg:data
tmux send-keys 'cd $HOME/workspace/senior-design/thesis/' Enter

tmux -2 attach-session -d



