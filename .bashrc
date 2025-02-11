# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=-1
HISTFILESIZE=-1

export PATH="$HOME/.local/bin:$PATH"

set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

PS1=''
PS1=$PS1'\[\033[1;36m\]\u'
PS1=$PS1'\[\033[34m\]@'
PS1=$PS1'\[\033[34m\]\H'
PS1=$PS1'\[\033[35m\] \W\n'
export PS1=$PS1'\[\033[33m\]λ \[\033[0m\]'

alias full-system-update="pipx upgrade-all && sudo emerge --sync && sudo emerge -auvDN @world"
alias full-system-update-bin="pipx upgrade-all && sudo emerge --sync && sudo emerge -gauvDN @world"
alias fetch="fastfetch"
alias icat="kitten icat"
alias ls='eza --icons'
alias ll='eza -lh --icons'
alias la='eza -lAh --icons'
alias lh='eza -a | grep ^\\.'
alias tree='eza -T --icons'
alias pygrep='rg -t python'
alias activate='source .venv/bin/activate || source $(fd -up --regex "bin/activate$ | head -n 1")'
alias shconf='nvim $HOME/.bashrc && source $HOME/.bashrc'
alias watch-mem='watch -n 2 grep -e "Dirty" -e "Writeback" /proc/meminfo'
alias kssh="kitten ssh"

toggle-coolerboost() {
    $HOME/dotfiles/scripts/toggle-coolerboost.sh
}

set-shift-mode() {
    msi_ec_path='/sys/devices/platform/msi-ec'
    shift_mode=$(cat $msi_ec_path/available_shift_modes | fzf)
    echo $shift_mode | sudo tee $msi_ec_path/shift_mode
}
    

bring-from-downloads () {
    filename=$(ls $HOME/Downloads | fzf);
    if [[ -z $filename ]]; then
        echo "No file selected";
    else
        mv -i $HOME/Downloads/$filename .;
    fi
}


# ################################################################################ #
# Git aliases/commands
# ################################################################################ #
alias gl='git log --oneline --graph'
alias gpsu='git push -u origin "$(git branch --show-current)"'
alias gpf="git push --force-with-lease"
alias gdiff-origin='git diff origin/$(git branch --show-current)'

gk() {
    branch=$1
    if [[ -z $branch ]]; then
        git checkout $(git branch | fzf | sed "s/^\*//");
    else
        git checkout $branch;
    fi
}

gka() {
    tmp_file="/tmp/git-checkout-branches.txt";
    git branch -lra | sed "s/^\*//" > $tmp_file;
    git tag -l  >> $tmp_file;
    cat $tmp_file | fzf | sed "s/^\ *remotes\/origin\///" | xargs git checkout;
    rm $tmp_file;
}

gstash() {
    command=$(echo -e "apply\ndrop\nlist\npop\npush" | fzf)
    echo $command
    if [[ -z $command ]]; then
        echo Aborted
        return 0
    fi

    if [[ $command == "push" ]]; then
        cat | xargs -- git stash push -m
        return 0
    fi

    if [[ $command == "list" ]]; then
        git stash list
        return 0
    fi

    entry=$(git stash list | fzf | sed -E 's/.*@\{([[:digit:]]+)\}:.*/\1/')
    if [[ -n $entry ]]; then
        git stash $command $entry
    else
        echo Aborted
    fi
}
# ################################################################################ #


start_sway() {
    # export XCURSOR_THEME="Adwaita";
    # export XCURSOR_SIZE=24;
    export XDG_CURRENT_DESKTOP="sway";
    export XDG_SESSION_TYPE="wayland";
    export XDG_SESSION_DESKTOP="sway";
    dbus-run-session sway;
}

export _ZO_ECHO=1
eval "$(fzf --bash)"
eval "$(zoxide init bash)"

if [[ -f $HOME/.bashrc_local ]]; then
    source $HOME/.bashrc_local
fi
