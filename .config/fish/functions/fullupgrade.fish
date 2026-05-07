function fullupgrade --description 'Complete system maintenance suite'
    pushd $HOME > /dev/null; or return 1

    upgrade; or begin
        set_color red; echo "❌ System upgrade failed"; set_color normal
        popd > /dev/null; return 1
    end

    gio trash --empty

    mise upgrade; or return 1
    mise prune
    mise install; or return 1

    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME maintenance run \
        --task=commit-graph \
        --task=incremental-repack \
        --task=loose-objects \
        --task=gc; or return 1

    popd > /dev/null
    set_color green
    echo "✅ Upgrade sequence complete."
    set_color normal
end
