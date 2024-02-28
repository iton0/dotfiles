# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/opt/nvim-linux64/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set up NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

 zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line to change how often to auto-update (in days).
 zstyle ':omz:update' frequency 7

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# FZF key bindings
source /usr/share/doc/fzf/examples/key-bindings.zsh

# FZF fuzzy auto-completion for commands
source /usr/share/doc/fzf/examples/completion.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.


# The 'dof' alias simplifies Git commands by using a custom
# repository location and working directory. It's used to manage
# configuration files and dotfiles centrally.

alias dof='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Alias Explanation:
#   - '--git-dir=$HOME/dotfiles/': Custom Git repository path.
#   - '--work-tree=$HOME': Working directory set to home.

# Example Usage:
#   - 'dof status': Check repo status.
#   - 'dof add file.txt': Stage changes.
#   - 'dof commit -m "Update"': Commit changes.
#   - 'dof push origin main': Push changes.

# Useful for managing dotfiles across systems.

# Using this alias, you can update package information
# and upgrade packages in one command.
# Additional autoremoves any packages no longer in use.
# Current package managers: apt and flatpak.

alias update='
  sudo apt update -y && \
  sudo apt upgrade -y && \
  sudo apt autoremove -y && \
  sudo apt autoclean -y && \
  sudo apt clean -y && \
  flatpak update -y
  '

# Alias for updating Starship prompt
alias star-update='curl -sS https://starship.rs/install.sh | sh'

# Alias for updating Neovim version
alias nvim-update='confirm_nvim_update'

# Set an alias 'v' for Neovim if available; otherwise, fallback to Vim
if command -v nvim &> /dev/null; then
    alias v='/opt/nvim-linux64/bin/nvim'
    alias vd='v .'
else
    alias v='/usr/bin/vim'
    alias vd='v .'
fi


confirm_nvim_update() {
    echo "Installing Neovim" &&
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz &&
    sudo rm -rf /opt/nvim &&
    sudo tar -C /opt -xzf nvim-linux64.tar.gz &&
    echo "--------------------------------" &&
    echo "New Neovim version:" &&
    /opt/nvim-linux64/bin/nvim --version &&
    rm nvim-linux64.tar.gz &&
    echo "--------------------------------" &&
    echo ""
}

# Aliases for convenient terminal commands:
alias ud='cd ..'
alias cl='clear'
alias hocl='cd && clear'
alias vtmx='v ~/.config/tmux/tmux.conf'
alias scpt='cd ~/.local/scripts'
alias vscpt='cd ~/.local/scripts && vd'
alias vzsh='v ~/.zshrc'
alias vgit='v ~/.gitconfig'
alias vstar='v ~/.config/starship.toml'
alias neo='cd ~/.config/nvim/lua/iton/'
alias neod='cd ~/.config/nvim/lua/iton/ && vd'
alias live='live-server'

# Other example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Initialize Starship prompt NOTE: needs to stay at bottom
eval "$(starship init zsh)"
