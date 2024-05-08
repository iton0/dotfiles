## Dotfiles Setup

> [!IMPORTANT]
> Assumes you are installing on Linux system or WSL distro

#### Introduction
This README serves two purposes: as a personal reference for myself and as a guide for others interested in managing their dotfiles using a git bare repository.

I maintain my dotfiles using this method, with the working tree set to my `$HOME` directory. The setup script provided below demonstrates how this is implemented.

##### Dotfiles Management Structure

When managing my dotfiles across multiple systems simultaneously, I use the following structure:


- **Primary Repository:** Push and pull to and from (respectively) remote repo

- **Secondary Repositories:** Only pull from remote repo

##### maybe-keep Branch

> [!NOTE]
> This branch is not cloned locally during installation

This branch ([maybe-keep](https://github.com/iton0/dotfiles/tree/maybe-keep)) on the dotfiles repository holds the configuration
files that are no longer needed but may be required in the future, hence the
name 'maybe-keep'.

Around every New Year, I will either reintegrate these configurations
into the main branch or delete them entirely.

----------

#### Installation
##### Prerequisites
- Copy or move ***.ssh***  folder in $HOME directory to new computer
    - Copy any other important folders (MAKE SURE THIS IS DONE)
- Make sure to have ***curl*** command:
`sudo apt update && sudo apt install curl`

##### How to Install
Paste command below in terminal:

```bash
curl -fsSL https://gist.githubusercontent.com/iton0/e5a6ab3a99c51bbf8cabc4dac9f7dff1/raw/setup_dotfiles.sh | bash
```

> [!NOTE]
> To review or update setup_dotfiles script [click here](https://gist.github.com/iton0/e5a6ab3a99c51bbf8cabc4dac9f7dff1)

----------

#### Important Notes
- Make sure to change terminal font to Fira Code Nerd Font (it should be a part
  of the options after initial reboot)
- The script `~/startup.sh` that automates workspace creation (I've tried i3 and
  it was mehhh) needs to be put as command for a new Startup
  Application in order to utilize
- Depending on your setup and configuration, you may need to install additional dependencies to ensure that your dotfiles function correctly
    - To install node and npm run `nvm install node`
- Running `zsh` will also run tmux only if not already in a tmux session
    - This will also happen everytime you restart your computer and open terminal
    - Additionally, it will pull from the remote repo and sync the Neovim plugins
- The git configuration ignores untracked files, which means any files you add to tracked folders will not show up until you manually add them using `dot add <filename/foldername>`
    - Think of `dot` as a custom git alias for dotfile management, enabling tasks like `dot add` or `dot branch -a` similar to standard git commands
    - Some custom git commands that will be helpful (found in ~/.gitconfig):
        - `dot cud` - Will add [cu]rrent working [d]irectory to tracking
        - `dot syc` - Will add all tracked files & commit with diff in core editor
- With FireFox there are two settings in the `about:config` (just type in
  ***about:config*** in the browser) that you need to
  change in regard to Linux:
    - `layout.css.devPixelsPerPx`: Controls the UI scaling. I found that a
      value around 1.2 is decent
    - `ui.key.menuAccessKeyFocuses`: Whether ALT key toggles
      the menu bar. I change this to false since I do not use menu bar
