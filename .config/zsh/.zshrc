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

# Utility Functions

# yt-dlp Music Downloader Function
ytdl-music() {
    local url="$1"
    local dry_run=false

    # 1. ARGUMENT HANDLING
    if [[ "$1" == "--dry" ]]; then
        dry_run=true
        url="$2"
    fi

    if [[ -z "$url" ]]; then
        echo -e "\033[1;33m[Usage]\033[0m ytdl-music [--dry] <URL>"
        return 1
    fi

    # 2. PATH SETUP
    local archive_file="${HOME}/.ytdl_music_archive.txt"
    local dest_dir="${HOME}/Music"
    if command -v xdg-user-dir &>/dev/null; then
        dest_dir="$(xdg-user-dir MUSIC)"
    fi
    mkdir -p "$dest_dir"

    # 3. DEPENDENCY CHECK
    local use_aria2=false
    command -v aria2c &>/dev/null && use_aria2=true
    
    if ! command -v ffmpeg &>/dev/null; then
        echo -e "\033[1;31m[Error]\033[0m FFmpeg not found. Required for conversion."
        return 1
    fi

    # 4. COMMAND CONSTRUCTION
    local cmd=(yt-dlp)

    # --- STABILITY & BYPASS ---
    cmd+=(--ignore-config --no-warnings --ignore-errors --no-mtime)
    cmd+=(--download-archive "$archive_file")
    
    # --- ANTI-THROTTLE (2026 Strategy) ---
    cmd+=(--sleep-requests 3 --sleep-interval 5 --max-sleep-interval 15)
    cmd+=(--extractor-args "youtube:player_client=ios,android,web;player_skip=webpage")

    # --- UNIVERSAL AUDIO FORMAT (iOS/Android/VLC) ---
    # We choose 'm4a' because it's native to Apple and Android
    cmd+=(-f "bestaudio[ext=m4a]/bestaudio/best")
    cmd+=(--extract-audio --audio-format m4a --audio-quality 0)

    # --- METADATA & TAGGING ---
    cmd+=(--embed-thumbnail --embed-metadata --embed-chapters)
    # Using jpg for thumbnails as it's more compatible with older Android car displays
    cmd+=(--convert-thumbnails jpg)
    cmd+=(--sponsorblock-remove "music_offtopic,intro,outro,selfpromo")
    cmd+=(--parse-metadata "playlist_index:%(track_number)s")

    # --- DOWNLOADER OPTIMIZATION ---
    if [[ "$use_aria2" == "true" ]]; then
        echo -e "\033[1;36m[Mode]\033[0m Turbo (Aria2)"
        cmd+=(--downloader aria2c --downloader-args "aria2c:-x 16 -k 1M")
    else
        echo -e "\033[1;33m[Mode]\033[0m Standard (Native)"
        cmd+=(--concurrent-fragments 10)
    fi

    # --- OUTPUT TEMPLATE (FIXED) ---
    cmd+=(--paths "$dest_dir")
    # Fixes the '02d' error and organizes by Album/Playlist
    cmd+=(-o "%(album,playlist_title|Single Songs)s/%(playlist_index&{:02d} - |)s%(title)s.%(ext)s")
    # Restrict filenames is GOOD for mobile transfers (prevents URL encoding errors)
    cmd+=(--restrict-filenames)

    # 5. EXECUTION
    if [[ "$dry_run" == "true" ]]; then
        echo -e "\033[1;35m[Dry Run]\033[0m Simulating destination path..."
        "${cmd[@]}" --simulate --print filename "$url"
    else
        echo -e "\033[1;34m[Syncing]\033[0m $url"
        "${cmd[@]}" "$url"
        local exit_status=$?
        [[ $exit_status -eq 0 ]] && echo -e "\033[1;32m[Success]\033[0m Sync complete."
        return $exit_status
    fi
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
