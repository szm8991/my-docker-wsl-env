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

export PATH="/root/.local/bin:$PATH"

f() {
  local file
  q=$1

  file=$(ag -l -g ""| fzf --query="$q" --select-1 --exit-0 -x)
  if [ -n "$file" ] ;then
    code "$file"
  fi
}
fd() {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
fs(){
  local file
  q=$1
  if [ -z "$q"] ;then
    q="."
  fi
  result=$(ag "$q" | fzf)
  IFS=':' read file line other <<< "$result"
  [ -n "$file" ] && code -g "$file":"$line";
}
# [ `alias | grep "^z=" | wc -l` != 0 ] && unalias z
j() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}