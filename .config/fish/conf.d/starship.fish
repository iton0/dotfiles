if type -q starship
    status is-interactive; and starship init fish | source
    status is-interactive; and enable_transience
end
