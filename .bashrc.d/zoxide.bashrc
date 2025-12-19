if command -v zoxide &> /dev/null; then
    export _ZO_ECHO=1
    eval "$(zoxide init bash)"
fi
