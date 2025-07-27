# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=-1
HISTFILESIZE=-1

export NPM_CONFIG_PREFIX=$HOME/.npm_install
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:$NPM_CONFIG_PREFIX/bin

set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

PS1=''
PS1=$PS1'\[\033[1;36m\]\u'
PS1=$PS1'\[\033[34m\]@'
PS1=$PS1'\[\033[34m\]\H'
PS1=$PS1'\[\033[35m\] \W\n'
export PS1=$PS1'\[\033[33m\]λ \[\033[0m\]'

alias fetch="fastfetch"
alias icat="kitten icat"
alias ls='eza --icons'
alias ll='eza -lh --icons'
alias la='eza -lAh --icons'
alias tree='eza -T --icons'
alias pygrep='rg -t python'
alias activate='source .venv/bin/activate || source $(fd -up --regex "bin/activate$ | head -n 1")'
alias shconf='nvim $HOME/.bashrc && source $HOME/.bashrc'
alias watch-mem='watch -n 2 grep -e "Dirty" -e "Writeback" /proc/meminfo'
alias kssh="kitten ssh"

lh () {
    eza -lah $1 | grep " \."
}

# alias lh='eza -a | grep ^\\.'

bring-from-downloads () {
    output_name=$1
    filename=$(ls --no-quotes $HOME/Downloads | fzf);
    if [[ -z $filename ]]; then
        echo "No file selected";
    else
        mv -i "$HOME/Downloads/${filename}" ./$output_name;
    fi
}


# ################################################################################ #
# Git aliases/commands
# ################################################################################ #
alias gtl='git tag --sort="-v:refname"'
alias gl='git log --oneline --graph'
alias gpsu='git push -u origin "$(git branch --show-current)"'
alias gpf="git push --force-with-lease"
alias gdiff-origin='git diff origin/$(git branch --show-current)'
alias gkb='git checkout -b'

gk() {
    branch=$1
    if [[ -z $branch ]]; then
        git checkout $(git branch | fzf | sed "s/^\*//");
    else
        git checkout $branch;
    fi
}

gclone() {
    identity=$(eza -f -I "*.pub|authorized_keys|known_hosts*" ~/.ssh | fzf)
    if [[ -n $identity ]]; then
        git clone -c core.sshCommand="ssh -i ~/.ssh/$identity" $1 $2
    fi
}

gka() {
    tmp_file="/tmp/git-checkout-branches.txt";
    git branch -lra | sed "s/^\*//" > $tmp_file;
    git tag -l  >> $tmp_file;
    cat $tmp_file | fzf | sed "s/^\ *remotes\/\origin\///" | xargs git checkout;
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


export _ZO_ECHO=1
eval "$(fzf --bash 2>/dev/null)"
eval "$(zoxide init bash)"

if [[ -f $HOME/.bashrc_local ]]; then
    source $HOME/.bashrc_local
fi
