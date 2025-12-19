# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /etc/profile.d/bash_completion.sh

HISTSIZE=-1
HISTFILESIZE=-1

shopt -s histappend

export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH:$HOME/.apify/bin"

set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# --- Function to get the Toolbox/Podman Container Name ---
get_container_name() {
    # Check if we are inside a container using the standard .containerenv file
    if [ -f "/run/.containerenv" ]; then
        # Use grep and sed to extract the name= attribute
        # Output: [container_name]
        TOOLBOX_NAME=$(grep -oP 'name="\K[^"]+' /run/.containerenv)
        # Use ANSI escape codes for coloring (e.g., green text)
        printf "$TOOLBOX_NAME"
    else
        printf "\H"
    fi
}


PS1=''
PS1=$PS1'\[\033[1;36m\]\u'
PS1=$PS1'\[\033[34m\]@'
PS1=$PS1'\[\033[34m\]$(get_container_name)'
PS1=$PS1'\[\033[35m\] \W\n'
export PS1=$PS1'\[\033[33m\]λ \[\033[0m\]'

if command -v eza &> /dev/null; then
    alias ls='eza --icons'
    alias ll='eza -lh --icons'
    alias la='eza -lAh --icons'
    alias tree='eza -T --icons'
    lh () {
        eza -lah $1 | grep " \."
    }
fi

if command -v rg &> /dev/null; then
    alias pygrep='rg -t python'
fi

if command -v fd &> /dev/null; then
    alias activate='source .venv/bin/activate || source $(fd -up --regex "bin/activate$ | head -n 1")'
fi

if command -v nvim &> /dev/null; then
    alias shconf='nvim $HOME/.bashrc && source $HOME/.bashrc'
fi

alias watch-mem='watch -n 2 grep -e "Dirty" -e "Writeback" /proc/meminfo'


# tma() {
#     if [ -n "$TMUX" ]; then
#         echo "Already inside a tmux instance!"
#         return 1
#     fi

#     selected_session=$(tmux start && tmux ls -F '#{session_name}' | fzf-smart)
#     tmux a -t $selected_session

# }



# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
