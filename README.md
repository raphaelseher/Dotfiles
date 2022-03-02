# Dotfiles

[Bare Git Repo Setup](https://www.atlassian.com/git/tutorials/dotfiles)

## Setup

```
echo ".cfg" >> .gitignore git clone --bare <git-repo-url> $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no
```
