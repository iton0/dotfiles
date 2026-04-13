### GLOBAL ENVIRONMENT
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx EDITOR nvim
set -gx PAGER "env LESS=FRX less"
set -gx MANPAGER "nvim +Man!"
set -gx FZF_DEFAULT_OPTS "--multi --cycle --border=none --style=minimal --layout=reverse"

set -g fish_greeting ""

### INTERACTIVE ONLY
if not status is-interactive
    return 0
end

# Auto-start TMUX
if not set -q TMUX; and not set -q TERMINAL_EMULATOR; and not set -q SSH_TTY
    tmux new-session -A -s HOME
end
