# dotfiles
My personal .dotfiles configuration

--- 
### Install your dotfiles on a new system, or migrate to this setup
1.   ` echo "dotfiles" >> .gitignore `

There could be weird behaviour if __dotfiles__ tries to track itself. Avoid recursive issues by adding __dotfiles__ to your global Git ignore.

 
2.   ` git clone <remote-git-repo-url> $HOME/.dotfiles`

Add a __--bare__ flat if you wish you use a bare repo

 
3.   `alias config='/usr/bin/git --git-dir=<path to .dotfiles’s Git directory> --work-tree=$HOME'`

Set up an alias to send Git commands to __dotfiles__, and also set $HOME as the work tree, while storing the Git state at __dotfiles__

For a bare repo, the path to the Git directory is at the top level of the project: `$HOME/dotfiles/`

For a non-bare default repo, the path to the Git directory is inside a .git subdirectory: `$HOME/dotfiles.git`

 
4.   `config config --local status.showUntrackedFiles no`

Set a local configuration in __dotfiles__ to ignore untracked files.

 
5.   `config checkout`

Checkout the actual content from your __dotfiles__ repository to $HOME. Git pulls the tracked files out of the compressed database in the Git directory and places them in the work tree.

E.g if you added `$HOME/.zsh/aliases` to dotfiles, that file will be instantiated at that path on your new computer. Ta Da!

__config checkout__ might fail with a message about files on your computer might have identical locations and names to files in the __dotfiles__ repo. Git doesn’t want to overwrite your local files.

Back up the files if they’re useful, delete them if they aren’t.

Run __config checkout__ again until you don’t get any errors.

Your dotfile setup is complete!

Treat your dotfile management system is like any other Git project. Just use the __config__ alias to add, commit, push and pull.
