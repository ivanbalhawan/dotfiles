if command -v fzf &> /dev/null; then

    bring-from-downloads () {
        output_name=$1
        filename=$(ls --no-quotes $HOME/Downloads | fzf);
        if [[ -z $filename ]]; then
            echo "No file selected";
        else
            mv -i "$HOME/Downloads/${filename}" ./$output_name;
        fi
    }

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

    # --- Smart fzf bindings for tmux-aware popups ---
    # Helper to pick fzf or fzf-tmux depending on environment

    # ---------------------------
    # Ctrl-R → search shell history
    # ---------------------------
    __fzf_history__ctrl_r__() {
      local selected
      selected=$(
        HISTTIMEFORMAT= history |
        fzf --tac --no-sort --ansi --tiebreak=index --scheme=history |
        sed 's/ *[0-9]* *//'
      ) || return
      READLINE_LINE="$selected"
      READLINE_POINT=${#READLINE_LINE}
    }
    bind -x '"\C-r": __fzf_history__ctrl_r__'


    # ---------------------------
    # Ctrl-T → fuzzy file finder
    # ---------------------------
    __fzf_file__ctrl_t__() {
      local selected
      selected=$(
        command find . -type f 2> /dev/null |
        fzf --multi --preview 'bat --style=numbers --color=always {} || cat {}'
      ) || return
      READLINE_LINE="${READLINE_LINE}${selected}"
      READLINE_POINT=${#READLINE_LINE}
    }
    bind -x '"\C-t": __fzf_file__ctrl_t__'

    # ---------------------------
    # Alt-C → jump to directory
    # ---------------------------
    __fzf_dir__alt_c__() {
      local dir
      dir=$(
        command find ${1:-.} -type d 2> /dev/null |
        fzf --preview 'tree -C {} | head -200'
      ) || return
      cd "$dir" || return
    }
    bind -x '"\ec": __fzf_dir__alt_c__'

fi
