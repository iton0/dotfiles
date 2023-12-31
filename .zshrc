# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
 export PATH=$HOME/bin:/usr/local/bin:$PATH
 export PATH="/opt/nvim-linux64/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set up NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
 zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
 zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
 DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
 HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
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

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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


# The 'config' alias simplifies Git commands by using a custom
# repository location and working directory. It's used to manage
# configuration files and dotfiles centrally.

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Alias Explanation:
#   - '--git-dir=$HOME/dotfiles/': Custom Git repository path.
#   - '--work-tree=$HOME': Working directory set to home.

# Example Usage:
#   - 'config status': Check repo status.
#   - 'config add file.txt': Stage changes.
#   - 'config commit -m "Update"': Commit changes.
#   - 'config push origin main': Push changes.

# Useful for managing dotfiles across systems.

# Using this alias, you can update package information
# and upgrade packages in one command.
# Additional autoremoves any packages no longer in use.
# Current package managers: apt and flatpak.

alias update='
  sudo apt-fast update &&
  sudo apt-fast upgrade &&
  sudo apt-fast autoremove &&
  sudo apt-fast autoclean &&
  sudo apt-fast clean &&
  sudo snap refresh &&
  flatpak update &&
  dpkg --get-selections > ~/package_list.txt &&
  echo "Package list updated!"'

# Set an alias 'v' for Neovim if available; otherwise, fallback to Vim
if command -v nvim &> /dev/null; then
    alias v='nvim'
    alias vd='nvim .'
else
    alias v='vim'
    alias vd='vim .'
fi

# Alias for updating Neovim version
alias nvim-update='confirm_nvim_update'

confirm_nvim_update() {
  read -r "REPLY?Make sure that the new nvim-linux64.tar.gz is in the Downloads folder before running this alias! Continue? (y/n): "
  if [[ "$REPLY" = "y" ]]; then
    cd ~/Downloads &&
    tar xzvf nvim-linux64.tar.gz &&
    echo "--------------------------------" &&
    echo "Old version:" &&
    nvim --version &&
    sudo rm -rf /opt/nvim-linux64/ &&
    echo "--------------------------------" &&
    echo "Old version deleted" &&
    sudo mv ~/Downloads/nvim-linux64 /opt &&
    echo "--------------------------------" &&
    echo "New version:" &&
    nvim --version &&
    echo "--------------------------------" &&
    read -r "REPLY?Would you like to delete the nvim-linux64.tar.gz? (y/n): "
    if [[ "$REPLY" = "y" ]]; then
      rm ~/Downloads/nvim-linux64.tar.gz &&
      cd &&
      echo "File removed"
    else
      cd &&
      echo "File not removed"
    fi
  else
    echo "Update cancelled."
  fi
}

# Aliases for convenient terminal commands:
alias ud='cd ..'
alias ho='cd'
alias cl='clear'
alias hocl='cd && clear'
alias vzsh='nvim ~/.zshrc'
alias vgit='nvim ~/.gitconfig'
alias neo='cd ~/.config/nvim'
alias neod='cd ~/.config/nvim && nvim .'
alias wez='cd ~/.config/wezterm'
alias wezd='cd ~/.config/wezterm && nvim .'
alias live='live-server'

# Other example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
