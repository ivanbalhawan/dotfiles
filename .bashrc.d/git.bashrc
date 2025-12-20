alias gtl='git tag --sort="-v:refname"'
alias gl='git log --oneline --graph'
alias gpsu='git push -u origin "$(git branch --show-current)"'
alias gpf="git push --force-with-lease"
alias gdiff-origin='git diff origin/$(git branch --show-current)'
alias gkb='git checkout -b'

gk() {
    branch=$1
    if [[ -z $branch ]]; then
        git checkout $(git branch | fzf-smart | sed "s/^\*//");
    else
        git checkout $branch;
    fi
}

gclone() {
    identity=$(eza -f -I "*.pub|authorized_keys|known_hosts*" ~/.ssh | fzf-smart)
    if [[ -n $identity ]]; then
        git clone -c core.sshCommand="ssh -i ~/.ssh/$identity" $1 $2
    fi
}

gka() {
    tmp_file="/tmp/git-checkout-branches.txt";
    git branch -lra | sed "s/^\*//" > $tmp_file;
    git tag -l  >> $tmp_file;
    cat $tmp_file | fzf-smart | sed "s/^\ *remotes\/\origin\///" | xargs git checkout;
    rm $tmp_file;
}

gstash() {
    command=$(echo -e "apply\ndrop\nlist\npop\npush" | fzf-smart)
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

    entry=$(git stash list | fzf-smart | sed -E 's/.*@\{([[:digit:]]+)\}:.*/\1/')
    if [[ -n $entry ]]; then
        git stash $command $entry
    else
        echo Aborted
    fi
}
