if command -v zellij &> /dev/null; then
    alias zellij-reset="zellij kill-all-sessions; zellij delete-all-sessions"
fi
