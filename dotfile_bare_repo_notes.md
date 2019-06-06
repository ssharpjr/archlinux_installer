### Dot Files Git Bare Repo Notes

Reference: [https://www.atlassian.com/git/tutorials/dotfiles]

##### Install dotfiles onto a new system

1. Add this alias to your .bashrc.  
  `alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

2. Tell git to ignore .cfg  
  `echo ".cfg" > .gitignore`

3. Clone your dotfiles repo  
  `git clone --bare <git-repo-url> $HOME/.cfg`

4. Checkout the actual content from the bare repo to your $HOME.  
  `config checkout`

5. Tell git to not show untracked files  
  `config config --local status.showUntrackedFiles no`


##### Automatic script

git clone --bare https://github.com/ssharpjr/cfg.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
