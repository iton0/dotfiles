export PATH="$HOME/.local/bin:$PATH"

export PATH="/opt/nvim-linux64/bin:$PATH"

# NOTE: Language specific paths go here
export PATH=$PATH:/usr/local/go/bin

export ZSH="$HOME/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

ENABLE_CORRECTION="true"

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    gh
    command-not-found
)

source $ZSH/oh-my-zsh.sh

source /usr/share/doc/fzf/examples/key-bindings.zsh

source /usr/share/doc/fzf/examples/completion.zsh

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

update() {
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean -y
    sudo apt clean -y
    flatpak update -y
}

fullupdate() {
    update
    nvim-update
}

add-dot() {
    rm -rf ~/.dotfiles/

    git clone --bare --depth 1 --filter=blob:none --branch main git@github.com:iton0/dotfiles.git "$HOME/.dotfiles"


    dot config remote.origin.fetch "+refs/heads/main:refs/remotes/origin/main"

    dot fetch
    dot checkout --force main

    dot pull --set-upstream origin main

    dot config --local rerere.enabled true

    dot config --local pull.rebase true

    dot config --local core.hooksPath ~/.config/githooks

    dot maintenance start
    dot restore ~/.gitconfig
}

nvim-update() {
    echo "Installing Neovim"
    echo "Old version:"
    /opt/nvim-linux64/bin/nvim --version
    echo "--------------------------------"
    echo ""
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim-linux64
    sudo mkdir -p /opt/nvim-linux64
    sudo chmod a+rX /opt/nvim-linux64
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/
    echo "--------------------------------"
    echo "New version:"
    /opt/nvim-linux64/bin/nvim --version
    rm nvim-linux64.tar.gz
    nvim --headless "+Lazy! sync" +qa
}

alias v='nvim'
alias vd='v .'
alias cl='clear'
alias hocl='cd && clear'
alias scpt='cd ~/.local/scripts'
alias vscpt='cd ~/.local/scripts && vd'
alias vzsh='v ~/.zshrc'
alias vhook='v ~/.config/githooks'
alias vgit='v ~/.gitconfig'
alias vign='v ~/.gitignore'
alias wez='cd ~/.config/wezterm/iton'
alias wezd='wez && vd'
alias neo='cd ~/.config/nvim/lua/iton'
alias neod='neo && vd'
fixaudio() {
    systemctl --user restart wireplumber pipewire pipewire-pulse
    rm -r ~/.config/pulse
}


eval "$(starship init zsh)"

# NOTE: this needs to happend after initializing of prompt
if [ ! -f ~/.config/starship.toml ]; then
    starship preset plain-text-symbols -o ~/.config/starship.toml
fi
