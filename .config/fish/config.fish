### GLOBAL ENVIRONMENT
set -gx PAGER "less -FRX"
set -gx FZF_DEFAULT_OPTS "--multi --cycle --border=none --style=minimal --layout=reverse"
set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'
set -gx CLAUDE_CONFIG_DIR "$HOME/.config/claude"
set -gx CLAUDE_CODE_NO_FLICKER 1

### INTERACTIVE ONLY
if not status is-interactive
    return 0
end

# 1. IO & STARTUP OPTIMIZATION
set -g fish_greeting ""
set -g fish_history_limit 5000
set -g __fish_git_prompt_show_informative_status 0
set -g __fish_git_prompt_show_dirtystate 0

# Auto-start TMUX
if status is-interactive
    and not set -q TMUX
    and not set -q TERMINAL_EMULATOR
    and not set -q SSH_TTY
    and command -sq tmux
        exec tmux new-session -A -s HOME
end
