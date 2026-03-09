export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
export PAGER="env LESS=FRX less"
export MANPAGER="nvim +Man!"

export FZF_DEFAULT_OPTS="--multi --cycle --border=none --style=minimal --layout=reverse"

CENTRAL_MACHINE="iton-darter"

zstyle ':omz:update' mode disabled

HISTSIZE=10000
SAVEHIST=10000
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE # Don't store 'history' or 'fc' commands themselves
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE

zsh_plugins=${ZDOTDIR:-~}/zsh_plugins
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

fpath=(${ZDOTDIR:-~}/antidote/functions $fpath)
autoload -Uz antidote

if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
    antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi
source ${zsh_plugins}.zsh

[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

source <(fzf --zsh)

if command -v uv &>/dev/null; then
    eval "$(uv generate-shell-completion zsh)"
fi

if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
else 
    ZSH_THEME="robbyrussell"
fi

alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias v=$EDITOR
alias cl='clear -x'
alias zshx='exec zsh'

run_toggle_system_theme() {
    source "$HOME"/.local/scripts/toggle-system-theme
}

upgrade() {
    "$HOME"/.local/scripts/system-maintenance "$@"
}

fullupgrade() {
    pushd "$HOME" > /dev/null
    upgrade
    
    gio trash --empty
    antidote update
    mise upgrade
    mise prune
    mise install

    if [[ "$(hostname)" != "$CENTRAL_MACHINE" ]]; then
        dot pl
    else
        dot add .
        dot cm "BIANNUAL UPDATE"
        dot p
    fi

    dot maintenance run --task=commit-graph --task=incremental-repack --task=loose-objects --task=gc
    popd > /dev/null
    echo "✅ Upgrade sequence complete."
}

ytdl-music() {
    local url="$1"
    local dry_run=false

    if [[ "$1" == "--dry" ]]; then
        dry_run=true
        url="$2"
    fi

    if [[ -z "$url" ]]; then
        echo -e "\033[1;33m[Usage]\033[0m ytdl-music [--dry] <URL>"
        return 1
    fi

    local archive_file="${HOME}/.ytdl_music_archive.txt"
    local dest_dir="${HOME}/Music"
    if command -v xdg-user-dir &>/dev/null; then
        dest_dir="$(xdg-user-dir MUSIC)"
    fi
    mkdir -p "$dest_dir"

    local use_aria2=false
    command -v aria2c &>/dev/null && use_aria2=true
    
    if ! command -v ffmpeg &>/dev/null; then
        echo -e "\033[1;31m[Error]\033[0m FFmpeg not found. Required for conversion."
        return 1
    fi

    local cmd=(yt-dlp)

    cmd+=(--ignore-config --no-warnings --ignore-errors --no-mtime)
    cmd+=(--download-archive "$archive_file")
    
    cmd+=(--sleep-requests 3 --sleep-interval 5 --max-sleep-interval 15)
    cmd+=(--extractor-args "youtube:player_client=ios,android,web;player_skip=webpage")

    cmd+=(-f "bestaudio[ext=m4a]/bestaudio/best")
    cmd+=(--extract-audio --audio-format m4a --audio-quality 0)

    cmd+=(--embed-thumbnail --embed-metadata --embed-chapters)
    cmd+=(--convert-thumbnails jpg)
    cmd+=(--sponsorblock-remove "music_offtopic,intro,outro,selfpromo")
    cmd+=(--parse-metadata "playlist_index:%(track_number)s")

    if [[ "$use_aria2" == "true" ]]; then
        echo -e "\033[1;36m[Mode]\033[0m Turbo (Aria2)"
        cmd+=(--downloader aria2c --downloader-args "aria2c:-x 16 -k 1M")
    else
        echo -e "\033[1;33m[Mode]\033[0m Standard (Native)"
        cmd+=(--concurrent-fragments 10)
    fi

    cmd+=(--paths "$dest_dir")
    cmd+=(-o "%(album,playlist_title|Single Songs)s/%(playlist_index&{:02d} - |)s%(title)s.%(ext)s")
    cmd+=(--restrict-filenames)

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

if [[ -z "$TMUX" ]] && \
   [[ -z "$TERMINAL_EMULATOR" ]] && \
   [[ -z "$SSH_TTY" ]] && \
   [[ $- == *i* ]]; then
    tmux new-session -A -s HOME
fi
