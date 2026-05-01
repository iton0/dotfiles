if status is-interactive; and test "$TERM" = "foot"
    set -l theme (gsettings get org.gnome.desktop.interface color-scheme | string replace -a "'" "")

    # Find the actual foot server process ID
    set -l foot_server_pid (pgrep -u $USER -x foot)

    if test -n "$foot_server_pid"
        if string match -q "*dark*" "$theme"
            kill -USR1 $foot_server_pid
        else
            kill -USR2 $foot_server_pid
        end
    end
end
