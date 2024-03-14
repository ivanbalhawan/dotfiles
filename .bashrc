# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'


source /usr/share/bash-completion/completions/eza
source /usr/share/bash-completion/completions/git
source /usr/share/bash-completion/completions/gsettings
source /usr/share/bash-completion/completions/sway
source /usr/share/bash-completion/completions/swaymsg
source /usr/share/bash-completion/completions/man
source /usr/share/bash-completion/completions/fd
source /usr/share/bash-completion/completions/jq
source /usr/share/bash-completion/completions/kill
source /usr/share/bash-completion/completions/killall
source /usr/share/bash-completion/completions/libreoffice
source /usr/share/bash-completion/completions/nmcli
source /usr/share/bash-completion/completions/rc-update
source /usr/share/bash-completion/completions/rc-status
source /usr/share/bash-completion/completions/rc-service
source /usr/share/bash-completion/completions/sftp

# source /usr/share/bash-completion/completions/systemctl
# source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

### Set env variables ###
HISTSIZE=-1
HISTFILESIZE=-1
export IPYTHONDIR="$HOME/.config/ipython"
export VISUAL_EDITOR="/usr/bin/nvim"
export GIT_EDITOR="/usr/bin/nvim"
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export PAGER="/usr/bin/less"
export MOZ_ENABLE_WAYLAND=1
export WLR_DRM_NO_MODIFIERS=1
export XDG_CURRENT_DESKTOP=sway

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="$PATH:~/.local/bin:~/dotfiles/scripts"

# customize prompt
PS1=''
PS1=$PS1'\[\033[1;36m\]\u'
PS1=$PS1'\[\033[34m\]@'
PS1=$PS1'\[\033[34m\]\H'
PS1=$PS1'\[\033[35m\] \W\n'
export PS1=$PS1'\[\033[33m\]λ \[\033[0;37m\]'

### Define Aliases ###
alias upscale='gamescope -h 1080 -H 1440 -F fsr -f'
alias gl='git log --oneline --graph'
alias gpsup='git push -u origin "$(git branch --show-current)"'
alias connect='/usr/bin/nmcli connection up'
alias volta-env='source ~/volta/dev/.volta-venv/bin/activate'
alias shconf='nvim ~/.bashrc'
alias swayconf='nvim ~/.config/sway/config'
alias riverconf='nvim ~/.config/river/init'
alias hyprconf='nvim ~/.config/hypr/hyprland.conf'

alias ls="eza"
alias ll="eza -lh"
alias la="eza -lAh"
alias tree="eza -T --level=3"

alias wifi="nmcli device wifi"


# Shell integration for Foot term
# osc7_cwd() {
#     local strlen=${#PWD}
#     local encoded=""
#     local pos c o
#     for (( pos=0; pos<strlen; pos++ )); do
#         c=${PWD:$pos:1}
#         case "$c" in
#             [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
#             * ) printf -v o '%%%02X' "'${c}" ;;
#         esac
#         encoded+="${o}"
#     done
#     printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
# }
# PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd


# Ranger function (to prevent nested ranger instances)
ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}
