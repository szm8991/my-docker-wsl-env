# alias
# git
alias gst='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gl='git pull'
alias gp='git push'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -- | less"
# ls
# [ `alias | grep "^ls=" | wc -l` != 0 ] && unalias ls
# alias ls='exa'
# alias ll='ls -lh'
# alias la='ls -alh'
# end

f() {
  local file
  q=$1

  file=$(ag -l -g ""| fzf --query="$q" --select-1 --exit-0 -x)
  if [ -n "$file" ] ;then
    code "$file"
  fi
}