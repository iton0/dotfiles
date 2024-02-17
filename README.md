## Installing on new system
##### This assumes that you are on a fresh new computer

1. Make sure to have SSH keys on new computer before moving to Step 2
    1. Copy and paste from .ssh folder in $HOME directory from old computer
to new computer

2. Run the bash command below:

```bash
sudo apt update && sudo apt install -y git && git clone --bare git@github.com:iton0/dotfiles.git $HOME/dotfiles && alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME" && config checkout && config config --local status.showUntrackedFiles no && $HOME/.local/scripts/install_tool
```
