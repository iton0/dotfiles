if not status is-interactive
    return 0
end

abbr -a dot 'git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
abbr -a v nvim
abbr -a cl 'clear -x'
abbr -a fishx 'exec fish'
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a - 'cd -'
