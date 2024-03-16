# Dotfiles

## Installing on new system

> [!NOTE]
> This assumes that you are on a fresh new computer without an already existing dotfile folder

> Make sure to have SSH keys on the new computer before running the bash command below

1. Copy or move .ssh folder in $HOME directory to new computer
2. Paste and run the command below in terminal:

````bash
curl -fsSL https://gist.githubusercontent.com/iton0/e5a6ab3a99c51bbf8cabc4dac9f7dff1/raw/setup_dotfiles.sh | bash
