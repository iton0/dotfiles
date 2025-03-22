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
plugins=(
    zsh-autosuggestions
)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'
source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias v='nvim'
alias vd='nvim "$(pwd)"'
alias cl='clear'
alias sus='systemctl suspend && cl'
alias hocl='cd && cl'
alias scpt='cd ~/.local/scripts'
alias scptd='scpt && vd'
alias vzsh='v ~/.zshrc'
alias vhk='v ~/.hkup'
alias vgit='v ~/.gitconfig'
alias vsway='v ~/.config/sway/config'
alias vway='v ~/.config/waybar/config.jsonc'
alias vtmux='v ~/.config/tmux/tmux.conf'
alias vign='v ~/.gitignore'
alias neo='cd ~/.config/nvim'
alias neod='neo && vd'
alias zshx='exec zsh'
bindkey -s '\et' '^u~/.local/scripts/toggle-system-theme^M'
run_tmux_sessionizer_widget() {
  tmux neww ~/.local/scripts/tmux-sessionizer
}
zle -N run_tmux_sessionizer_widget
bindkey '^f' run_tmux_sessionizer_widget
update() {
	sudo dnf upgrade --refresh -y
	sudo dnf autoremove -y
	sudo dnf clean all
	sudo dnf check-update --security
	sudo dnf clean packages
    flatpak update --appstream -y
    flatpak update -y
    flatpak uninstall --unused -y
}
fullupdate() {
    update
    nvim --headless "+Lazy! sync" +qa
    gio trash --empty
}
dotauto() {
	pushd $HOME
    dot auto
	popd
}
post-install() {
    nvm install --lts
    nvim --headless "+Lazy! install" +qa
    dot restore .
    nvim --headless "+Lazy! restore" +qa
	update
}
fixaudio() {
    systemctl --user restart wireplumber pipewire pipewire-pulse
    rm -r ~/.config/pulse
}
eval "$(starship init zsh)"
if [[ -z "$TMUX" ]]; then
    tmux new-session -A -s HOME 'git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch && git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status -sb && echo -e "\n \\033[4mDotfiles Status\\033[0m"; zsh'
fi
