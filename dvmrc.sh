# shellcheck shell=bash
# shellcheck disable=SC2034,SC2164,SC1090,SC1091
# shellcheck source-path=/home/dn/
ZSH_THEME="robbyrussell"

export ps1=$PS1
cd /home/dn/cheetah/env/linux/
source defenv wbox
source ~/cheetah/env/linux/defenv.zsh
export PS1="%F{magenta}$PROD ${ps1}"

alias rcc="fd -I compile_commands.json -X rm -rf"
alias fps='PS1="${PROD} ${ps1}"'
alias wbc="wbox_connect"
alias dbb="dbuild make -i wb_builder wbox"
alias gct="git clean -xdf ~/cheetah/src/tests/.ipython"
alias wbc="ssh \$(cat ~/borrowed_wbox) -p 2222"

super-clean()
{
  clear_containers
  sudo git clean -xdf
  git reset --hard
  git fetch -p
  git gc --prune=now
  git remote prune origin
  docker system prune -a
}

docker-wait-enter ()
{
  while [ ! "$(docker ps -q -f name="$1")" ]; do
    echo "waiting for $1"
    sleep 2
  done
  sleep "$2"
  docker-enter "$1"
}

set-pyborrow ()
{
  echo "$1" > ~/borrowed_wbox
}

wbox-sync ()
{
  git ls-files --modified | xargs -I{} scp -P 2222 {} dn@"$(cat ~/borrowed_wbox)":/home/dn/cheetah/{}
}

source ~/.profile
source ~/.aliases

tmux bind-key C-w switch-client -Twbox
tmux bind-key -Twbox C-w select-window -t wbox
tmux bind-key -Twbox C-b send-keys -t wbox "dbuild make -i wb_builder wbox" C-m
tmux bind-key -Twbox C-c run wbox_pane_connect
tmux bind-key -Twbox C-l run wbox_split_logs
tmux bind-key -Twbox C-s run "$(wbox_sync)"

tmux bind-key C-c switch-client -Tconsole
tmux bind-key -Tconsole C-b send-keys -t console.1 "dbuild make -i wb_builder wbox" C-m
tmux bind-key -Tconsole C-r send-keys "request system process restart ncp 0 datapath wb_fe_agent" C-m "yes" C-m
# tmux bind-key -Tconsole C-l split-window -h -t console.1 \; send-keys -t console.2 "docker-enter mgmt_datapath1_1" C-m "traces; clear; tail -f wb_fe_agent" C-m
# tmux bind-key -Tconsole C-s split-pane -t console.2 \; send-keys -t console.3 "docker-enter mgmt_datapath1_1" C-m "clear; supervisorctl fg wb_fe_agent" C-m

if [[ -z $TMUX ]]; then
  if ! tmux has-session -t dvm; then
    tmux new-session -s dvm -n editor -d
    tmux send-keys -t dvm "lvim" C-m
    tmux new-window -n console -t dvm
    tmux select-window -t dvm:1
  fi
  tmux attach -t dvm
fi
