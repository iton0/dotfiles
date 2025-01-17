# NOTE: Language specific paths go here
if [[ ! "$PATH" =~ "/usr/local/go/bin" ]]; then
    export PATH="$PATH:/usr/local/go/bin"
fi
if [[ ! "$PATH" =~ "/home/iton/go/bin" ]]; then
    export PATH="$PATH:/home/iton/go/bin"
fi
if [[ ! "$PATH" =~ "$HOME/zig-linux-x86_64-0.13.0" ]]; then
	export PATH="$HOME/zig-linux-x86_64-0.13.0:$PATH"
fi
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
if command -v pacman >/dev/null 2>&1; then # Arch
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
else
	source /usr/share/doc/fzf/examples/key-bindings.zsh
	source /usr/share/doc/fzf/examples/completion.zsh
fi
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
update() {
	if command -v pacman >/dev/null 2>&1; then # Arch
		sudo pacman -Syu --noconfirm
		sudo pacman -Rns $(pacman -Qdtq) --noconfirm
		sudo pacman -Scc --noconfirm
	else
		sudo apt update
		sudo apt upgrade -y
		sudo apt autoremove -y
		sudo apt autoclean
		sudo apt clean
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
alias sus='systemctl suspend'
alias hocl='cd && clear'
alias scpt='cd ~/.local/scripts'
alias vscpt='cd ~/.local/scripts && vd'
alias vzsh='v ~/.zshrc'
alias vhk='v ~/.hkup'
alias vgit='v ~/.gitconfig'
alias vsway='v ~/.config/sway/config'
alias vign='v ~/.gitignore'
alias wez='cd ~/.config/wezterm/iton'
alias wezd='wez && vd'
alias neo='cd ~/.config/nvim'
alias neod='neo && vd'
eval "$(starship init zsh)"
