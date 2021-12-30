function peco-tmux-attach
    set SESSIONS (tmux list-sessions)
    if test -z "$SESSIONS"
        tmux new-session
        return
    end

    set NEW_SESSION_MSG "Create New Session"
    echo -e (string join "\n" (tmux list-sessions))"\n$NEW_SESSION_MSG" | peco --on-cancel=error | read recent
    set ID (echo $recent | cut -d: -f1)

    if test "$ID" = "$NEW_SESSION_MSG"
        tmux new-session -d
        tmux list-sessions | tail -n 1 | cut -d: -f1 | xargs tmux switch-client -t
    else if test -n "$ID"
        tmux switch-client -t "$ID"
    end
end
