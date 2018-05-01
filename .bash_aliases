##############################################
# ALIASES
##############################################

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias cat="pygmentize -g"
alias lh='ls -alh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# == start Git aliases
alias gitlog="git log --color --graph --pretty=format:'%Cgreen[%Creset%h%Cgreen]%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gittoday="git log --color --graph --pretty=format:'%Cgreen[%Creset%h%Cgreen]%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --since=yesterday"
alias commit='git commit'
alias gb='git branch -v'
alias gc='git commit -m'
alias gt='git commit -m "smallfix"'
alias ga='git add .'
alias gd='git diff'
alias gr='git rm'
alias gss='git status'
alias gs='git status -s'
alias gpl='git pull origin'
alias gush='git push origin'
alias gco='git checkout'
alias amend='git commit --amend'
# == end Git aliases

alias du='du -k -d 1 | sort -nr'    # Makes a more readable output.
alias df='df -kTh'
alias bc="bc -l"
alias ping="ping -c 5"

# == start Docker aliases
alias dockl='docker ps -l -q'
alias dockpsa='docker ps -a'
alias dockimg='docker images'
alias dockclean='docker stop $(docker ps -aq) ; docker rm $(docker ps -aq)'
# == end Docker aliases

alias cd..="cd .."
alias virc="vim ~/.bashrc"
alias sorc="source ~/.bashrc"
alias mkdir="mkdir -p"

alias npmNgx="npm start &> npmNgx.out &"
