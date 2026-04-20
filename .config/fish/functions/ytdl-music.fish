function ytdl-music --description 'Download music via yt-dlp'
    set -l url $argv[-1] # Get the last argument as URL
    set -l dry_run false

    # Check for dry run flag
    if contains -- --dry $argv
        set dry_run true
    end

    if test -z "$url"
        set_color yellow
        echo "[Usage] ytdl-music [--dry] <URL>"
        set_color normal
        return 1
    end

    set -l archive_file "$HOME/.ytdl_music_archive.txt"
    set -l dest_dir "$HOME/Music"
    
    if type -q xdg-user-dir
        set dest_dir (xdg-user-dir MUSIC)
    end
    mkdir -p "$dest_dir"

    if not type -q ffmpeg
        set_color red
        echo "[Error] FFmpeg not found."
        set_color normal
        return 1
    end

    # Build the command array
    set -l cmd yt-dlp --ignore-config --no-warnings --ignore-errors --no-mtime \
        --download-archive "$archive_file" \
        --sleep-requests 3 --sleep-interval 5 --max-sleep-interval 15 \
        --extractor-args "youtube:player_client=ios,android,web;player_skip=webpage" \
        -f "bestaudio[ext=m4a]/bestaudio/best" \
        --extract-audio --audio-format m4a --audio-quality 0 \
        --embed-thumbnail --embed-metadata --embed-chapters \
        --convert-thumbnails jpg \
        --sponsorblock-remove "music_offtopic,intro,outro,selfpromo" \
        --parse-metadata "playlist_index:%(track_number)s" \
        --paths "$dest_dir" \
        -o "%(album,playlist_title|Single Songs)s/%(playlist_index&{:02d} - |)s%(title)s.%(ext)s" \
        --restrict-filenames

    # Check for aria2c
    if type -q aria2c
        echo (set_color cyan)"[Mode] Turbo (Aria2)"(set_color normal)
        set -a cmd --downloader aria2c --downloader-args "aria2c:-x 16 -k 1M"
    else
        echo (set_color yellow)"[Mode] Standard (Native)"(set_color normal)
        set -a cmd --concurrent-fragments 10
    end

    if test "$dry_run" = true
        echo (set_color magenta)"[Dry Run] Simulating..."(set_color normal)
        $cmd --simulate --print filename "$url"
    else
        echo (set_color blue)"[Syncing] $url"(set_color normal)
        $cmd "$url"
        if test $status -eq 0
            echo (set_color green)"[Success] Sync complete."(set_color normal)
        end
    end
end
