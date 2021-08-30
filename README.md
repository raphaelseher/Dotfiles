# Dotfiles

[Bare Git Repo Setup](https://www.ackama.com/blog/posts/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained?utm_source=pocket_mylist)

## Setup
´´´echo ".cfg" >> .gitignore´´´
´´´git clone <remote-git-repo-url> $HOME/.cfg´´´
´´´alias config='/usr/bin/git --git-dir=<path to .cfg’s Git directory> --work-tree=$HOME'´´´
´´´config config --local status.showUntrackedFiles no´´´
´´´config checkout´´´
