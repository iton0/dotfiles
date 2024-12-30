export PATH="$HOME/.local/bin:$PATH"

export PATH="/opt/nvim-linux64/bin:$PATH"

# NOTE: Language specific paths go here
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/iton/go/bin

export ZSH="$HOME/.oh-my-zsh"
export MANPAGER="nvim +Man!"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

ENABLE_CORRECTION="true"

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
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
    sudo apt autoclean
    sudo apt clean
    if ! grep -qiE "(Microsoft|WSL)" /proc/version; then
        flatpak update -y
    fi
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

    dot config --local core.hooksPath .hkup

    dot maintenance start
}

nvim-update() {
    echo "Installing Neovim"
    echo "Old version:"
    nvim --version
    echo "--------------------------------"
    echo ""
	cd ~/.neovim
    git fetch --depth 1 origin tag stable
	git reset --hard refs/tags/stable
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
	cd -
    echo "--------------------------------"
    nvim --headless "+Lazy! sync" +qa
	echo "New version:"
	nvim --version
}

post-install() {
	nvm install --lts
    nvim --headless "+Lazy! restore" +qa
	gh auth login
}

fixperf() {
	free && sync && echo 3 | sudo tee /proc/sys/vm/drop_caches && free
}

fixaudio() {
    systemctl --user restart wireplumber pipewire pipewire-pulse
    rm -r ~/.config/pulse
}

alias v='nvim'
alias vd='v .'
alias hu='hkup'
alias cl='clear'
alias hocl='cd && clear'
alias scpt='cd ~/.local/scripts'
alias vscpt='cd ~/.local/scripts && vd'
alias vzsh='v ~/.zshrc'
alias vhk='v ~/.hkup'
alias vgit='v ~/.gitconfig'
alias vign='v ~/.gitignore'
alias wez='cd ~/.config/wezterm/iton'
alias wezd='wez && vd'
alias neo='cd ~/.config/nvim'
alias neod='neo && vd'

eval "$(starship init zsh)"
