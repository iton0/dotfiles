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

ZSH_THEME=robbyrussell

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    gh
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


# The 'dot' alias simplifies Git commands by using a custom
# repository location and working directory. It's used to manage
# configuration files and dotfiles centrally.

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Alias Explanation:
#   - '--git-dir=$HOME/dotfiles/': Custom Git repository path.
#   - '--work-tree=$HOME': Working directory set to home.

# Example Usage:
#   - 'dot status': Check repo status.
#   - 'dot add file.txt': Stage changes.
#   - 'dot commit -m "Update"': Commit changes.
#   - 'dot push origin main': Push changes.

# Useful for managing dotfiles across systems.

# Using this alias, you can update package information
# and upgrade packages in one command.
# Additional autoremoves any packages no longer in use.
# Current package managers: apt and flatpak.

alias update=' \
    sudo apt update && \
    sudo apt upgrade -y && \
    sudo apt autoremove -y && \
    sudo apt autoclean -y && \
    sudo apt clean -y && \
    flatpak update -y \
    '

# Alias for biannual laptop maintainence
alias fullupdate=' \
    update && \
    nvim-update && \
    omz update \
    '

# Alias for updating Neovim version
alias nvim-update='confirm_nvim_update'
confirm_nvim_update() {
    echo "Installing Neovim" &&
    echo "Old version:" &&
    /opt/nvim-linux64/bin/nvim --version &&
    echo "--------------------------------" &&
    echo "" &&
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz &&
    sudo rm -rf /opt/nvim-linux64 &&
    sudo mkdir -p /opt/nvim-linux64 &&
    sudo chmod a+rX /opt/nvim-linux64 &&
    sudo tar -C /opt -xzf nvim-linux64.tar.gz &&
    # make it available in /usr/local/bin, distro installs to /usr/bin
    sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/ &&
    echo "--------------------------------" &&
    echo "New version:" &&
    /opt/nvim-linux64/bin/nvim --version &&
    rm nvim-linux64.tar.gz &&
    echo "--------------------------------" &&
    echo "" &&
    nvim --headless "+Lazy! sync" "+TSUpdateSync" "+MasonToolsUpdateSync" +qa # Syncs neovim plugins in headless mode
}

# Aliases for convenient terminal commands:
alias ud='cd ..'
alias cl='clear'
alias hocl='cd && clear'
alias vtmux='v ~/.config/tmux/tmux.conf'
alias scpt='cd ~/.local/scripts'
alias vscpt='cd ~/.local/scripts && vd'
alias vzsh='v ~/.zshrc'
alias vgit='v ~/.gitconfig'
alias vterm='v ~/.config/wezterm/wezterm.lua'
alias neo='cd ~/.config/nvim/lua/iton'
alias neod='neo && vd'
alias fixaudio='systemctl --user restart wireplumber pipewire pipewire-pulse && rm -r ~/.config/pulse && sudo apt install --reinstall alsa-base alsa-utils linux-sound-base libasound2 && sudo apt reinstall libpipewire-0.3-0 libpipewire-0.3-common libpipewire-0.3-modules pipewire pipewire-audio-client-libraries pipewire-bin pipewire-pulse && sudo alsa force-reload && systemctl --user status pipewire && sudo apt update && sudo apt upgrade'

# Set an alias 'v' for Neovim if available; otherwise, fallback to Vim
if command -v nvim &> /dev/null; then
    alias v='/opt/nvim-linux64/bin/nvim'
    alias vd='v .'
else
    alias v='/usr/bin/vim'
    alias vd='v .'
fi

# Other example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Check if we are not already in a tmux session
if [[ -z "$TMUX" ]]; then
    tmux new-session -As home '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull && nvim --headless "+Lazy! sync" "+TSUpdateSync" "+MasonToolsUpdateSync" +qa; $SHELL'
    clear
fi
