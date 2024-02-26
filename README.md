# Dotfiles
## Installing on new system
##### This assumes that you are on a fresh new computer without an already existing dotfile folder

1. **\*\*\*IMPORTANT\*\*\***  Make sure to have SSH keys on new computer before running bash command below
    1. Copy or move .ssh folder in $HOME directory from old computer
to new computer and run the bash command below:
```bash
cd && sudo apt update && \
sudo apt install -y git && \
chmod 700 ~/.ssh && \
chmod 600 ~/.ssh/id_ed25519 && \
chmod 644 ~/.ssh/id_ed25519.pub && \
eval "$(ssh-agent -s)" && \
ssh-add -l | grep -q "256" || ssh-add ~/.ssh/id_ed25519 && \
git config --global user.name "iton0" && \
git config --global user.email "iton442@gmail.com" && \
git clone --bare git@github.com:iton0/dotfiles.git $HOME/dotfiles && \
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME" && \
config remote add origin git@github.com:iton0/dotfiles.git && \
config checkout --force && \
[ $? -eq 0 ] || { echo "Error during 'config checkout'. Backup existing dotfiles and try again."; exit 1; } && \
ssh -T git@github.com && \
config config --local status.showUntrackedFiles no && \
echo "Dotfiles successfully added!" && \
echo "Now running install_tool script" && \
$HOME/.local/scripts/install_tool
```
