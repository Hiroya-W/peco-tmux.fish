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
        tmux new-session
    else if test -n "$ID"
        tmux attach-session -t "$ID"
    end
end
