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

super-clean()
{
  clear_containers
  sudo git clean -xdf
  git reset --hard
  git fetch -p
  delete_gone_branches
  git gc --prune=now
  git remote prune origin
  docker system prune -a
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
tmux bind-key -Twbox b send-keys -t wbox "dbuild make -i wb_builder wbox" C-m
tmux bind-key -Twbox c run wbox_pane_connect
tmux bind-key -Twbox l run wbox_split_logs

tmux bind-key b send-keys -t console "dbuild make -i wb_builder wbox" C-m

if [[ -z $TMUX ]]; then
  if ! tmux has-session -t dvm; then
    tmux new-session -s dvm -n editor -d
    tmux send-keys -t dvm "lvim" C-m
    tmux new-window -n console -t dvm
    tmux select-window -t dvm:1
  fi
  tmux attach -t dvm
fi
