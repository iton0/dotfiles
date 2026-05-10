function dot --description 'base dotfiles git command'
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
