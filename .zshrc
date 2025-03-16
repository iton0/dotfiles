if [[ ! "$PATH" =~ "/usr/local/go/bin" ]]; then
    export PATH="$PATH:/usr/local/go/bin"
fi
if [[ ! "$PATH" =~ "/home/iton/go/bin" ]]; then
    export PATH="$PATH:/home/iton/go/bin"
fi
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export PAGER="env LESS=FRX less"
export MANPAGER="nvim +Man!"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
ENABLE_CORRECTION="true"
plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
if command -v apt >/dev/null 2>&1; then
	source /usr/share/doc/fzf/examples/key-bindings.zsh
	source /usr/share/doc/fzf/examples/completion.zsh
else
	source /usr/share/fzf/shell/key-bindings.zsh
fi
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias v='nvim'
alias vd='v .'
alias hu='hkup'
alias cl='clear'
alias sus='systemctl suspend && cl'
alias hocl='cd && clear'
alias scpt='cd ~/.local/scripts'
alias scptd='cd ~/.local/scripts && vd'
alias vzsh='v ~/.zshrc'
alias vhk='v ~/.hkup'
alias vgit='v ~/.gitconfig'
alias vsway='v ~/.config/sway/config'
alias vtmux='v ~/.config/tmux/tmux.conf'
alias vign='v ~/.gitignore'
alias neo='cd ~/.config/nvim'
alias neod='neo && vd'
alias zshx='exec zsh'
bindkey -s '\et' '^u~/.toggle-terminal-theme^M'
update() {
	if command -v apt >/dev/null 2>&1; then
		sudo apt update
		sudo apt upgrade -y
		sudo apt autoremove -y
		sudo apt autoclean
		sudo apt clean
	else
		sudo dnf update -y
		sudo dnf upgrade --refresh -y
		sudo dnf autoremove -y
		sudo dnf clean all
		sudo dnf check-update --security
		sudo dnf clean packages
	fi
	flatpak update --appstream
	flatpak update
	flatpak uninstall --unused
}
fullupdate() {
    update
    nvim-update
	rm ~/.zsh_history
	gio trash --empty
}
add-dot() {
    rm -rf ~/.dotfiles/
	git clone --bare --depth 1 --filter=blob:none git@gitlab.com:iton0/dotfiles.git "$HOME/.dotfiles"
	dot config remote.origin.fetch "+refs/heads/main:refs/remotes/origin/main"
	dot fetch
	dot checkout --force main
	dot pull --set-upstream origin main
	dot config --local rerere.enabled true
	dot config --local pull.rebase true
	dot config --local core.hooksPath .hkup
	dot remote add backup git@github.com:iton0/dotfiles.git
	dot remote set-url --push backup "DISABLED [PULL-ONLY MIRROR]"
	dot maintenance start
}
nvim-update() {
	cd ~/.neovim
    git fetch --depth 1 --force origin tag stable
	git reset --hard refs/tags/stable
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
	cd -
    nvim --headless "+Lazy! sync" +qa
	nvim --version
}
post-install() {
	nvm install --lts
    nvim --headless "+Lazy! install" +qa
	dot restore .
    nvim --headless "+Lazy! restore" +qa
}
fixaudio() {
    systemctl --user restart wireplumber pipewire pipewire-pulse
    rm -r ~/.config/pulse
}
theme.sh selenized-dark
eval "$(starship init zsh)"
if [[ -z "$TMUX" ]]; then
  tmux new-session -A -s HOME 'git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch && git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status -sb && echo -e "\n \\033[4mDotfiles Status\\033[0m"; zsh'
fi
