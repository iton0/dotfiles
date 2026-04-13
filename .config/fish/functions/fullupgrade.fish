function fullupgrade --description 'Complete system maintenance suite'
    pushd $HOME > /dev/null
    
    upgrade
    
    gio trash --empty
    
    mise upgrade
    mise prune
    mise install

    dot maintenance run --task=commit-graph --task=incremental-repack --task=loose-objects --task=gc
    
    popd > /dev/null
    set_color green
    echo "✅ Upgrade sequence complete."
    set_color normal
end
