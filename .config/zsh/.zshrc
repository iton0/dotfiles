# ------------------------------------------------------------------------------
# 1. ENVIRONMENT & GLOBALS
# ------------------------------------------------------------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
export PAGER="env LESS=FRX less"
export MANPAGER="nvim +Man!"

# FZF modern styling
export FZF_DEFAULT_OPTS="--multi --cycle --border=none --style=minimal --layout=reverse"

CENTRAL_MACHINE="iton-darter"
ZSH_THEME="robbyrussell"

# Disable Oh My Zsh auto-update prompts (handled by your upgrade function)
zstyle ':omz:update' mode disabled

# ------------------------------------------------------------------------------
# 2. PLUGIN MANAGEMENT (Antidote)
# ------------------------------------------------------------------------------
zsh_plugins=${ZDOTDIR:-~}/zsh_plugins
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

fpath=(${ZDOTDIR:-~}/antidote/functions $fpath)
autoload -Uz antidote

# Static loading: only re-bundle if the .txt file changed
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
    antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi
source ${zsh_plugins}.zsh

# ------------------------------------------------------------------------------
# 3. TOOL INITIALIZATION (Mise, UV, FZF)
# ------------------------------------------------------------------------------
# Source local environment safely (Fixed path logic)
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# Use --lazy to prevent mise from slowing down every new tab
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

# FZF shell integration
source <(fzf --zsh)

# UV shell completion
if command -v uv &>/dev/null; then
    eval "$(uv generate-shell-completion zsh)"
fi

# ------------------------------------------------------------------------------
# 4. ALIASES & FUNCTIONS
# ------------------------------------------------------------------------------
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias v=$EDITOR
alias cl='clear -x'
alias zshx='exec zsh'

# System Maintenance Functions
run_toggle_system_theme() {
    source "$HOME"/.local/scripts/toggle-system-theme
}

upgrade() {
    "$HOME"/.local/scripts/system-maintenance "$@"
}

fullupgrade() {
    pushd "$HOME" > /dev/null
    upgrade
    
    # Clean up
    gio trash --empty
    antidote update
    mise upgrade
    mise prune
    mise install

    # Sync configs based on machine role
    if [[ "$(hostname)" != "$CENTRAL_MACHINE" ]]; then
        dot pl
        nvim --headless -c "lua MiniDeps.later(function() MiniDeps.snap_load(); MiniDeps.clean({ force = true }); vim.cmd('qa') end); vim.wait(30000, function() return false end)"
    else
        # On Central: Stage changes and push
        dot add .
        dot cm "BIANNUAL UPDATE"
        dot p
    fi

    # Optimize dotfiles repo
    dot maintenance run --task=commit-graph --task=incremental-repack --task=loose-objects --task=gc
    popd > /dev/null
    echo "✅ Upgrade sequence complete."
}

post-install() {
    upgrade
    mise use -g usage shellcheck lua-language-server
    mise install
    nvim --headless -c "lua MiniDeps.later(function() MiniDeps.snap_load(); MiniDeps.clean({ force = true }); vim.cmd('qa') end); vim.wait(120000, function() return false end)"
}

# ------------------------------------------------------------------------------
# 5. TMUX AUTO-START (Safe Guarded)
# ------------------------------------------------------------------------------
# Starts TMUX unless: 1. Already in TMUX, 2. In VS Code, 3. In an SSH session
if [[ -z "$TMUX" ]] && \
   [[ -z "$TERMINAL_EMULATOR" ]] && \
   [[ "$TERM_PROGRAM" != "vscode" ]] && \
   [[ -z "$SSH_TTY" ]] && \
   [[ -o interactive ]]; then
    tmux new-session -A -s HOME
fi
