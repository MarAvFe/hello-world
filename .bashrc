# ~/.bashrc: executed by bash(0) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ====================== START PS1 ======================

# \a    an ASCII bell character (07)
# \d  the date in "Weekday Month Date" format (e.g., "Tue May 26")
# \]  end a sequence of non-printing characters
# \e  an ASCII escape character (033)
# \h  the hostname up to the first `.'
# \H  the hostname
# \j  the number of jobs currently managed by the shell
# \l  the basename of the shell's terminal device name
# \n  newline
# \r  carriage return
# \s  the name of the shell, the basename of $0 (the portion following the final slash)
# \t  the current time in 24-hour HH:MM:SS format
# \T  the current time in 12-hour HH:MM:SS format
# \@  the current time in 12-hour am/pm format
# \A  the current time in 24-hour HH:MM format
# \u  the username of the current user
# \v  the version of bash (e.g., 2.00)
# \V  the release of bash, version + patchelvel (e.g., 2.00.0)
# \w  the current working directory
# \W  the basename of the current working directory
# \!  the history number of this command
# \#  the command number of this command
# \$  if the effective UID is 0, a #, otherwise a $
#  \nnn    the character corresponding to the octal number nnn
#  \\  a backslash
#  \[  begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt

#PS1='\[\e[1;32m\]\t \[\e[1;35m\]\u\[\e[1;34m\] \W\a\[\033[00m\]\$ '
#PS1='\[\e[1;32m\]┌─\t \[\e[1;35m\]\u\[\e[1;34m\] \W\a/\n\[\e[1;32m\]└\[\033[    00m\]\$ '

# Normal Colors
Black='\[\e[0;30m\]'        # Black
Red='\[\e[0;31m\]'          # Red
Green='\[\e[0;32m\]'        # Green
Yellow='\[\e[0;33m\]'       # Yellow
Blue='\[\e[0;34m\]'         # Blue
Purple='\[\e[0;35m\]'       # Purple
Cyan='\[\e[0;36m\]'         # Cyan
White='\[\e[0;37m\]'        # White

# Bold
BBlack='\[\e[1;30m\]'       # Black
BRed='\[\e[1;31m\]'         # Red
BGreen='\[\e[1;32m\]'       # Green
BYellow='\[\e[1;33m\]'      # Yellow
BBlue='\[\e[1;34m\]'        # Blue
BPurple='\[\e[1;35m\]'      # Purple
BCyan='\[\e[1;36m\]'        # Cyan
BWhite='\[\e[1;37m\]'       # White

# Background
On_Black='\[\e[40m\]'       # Black
On_Red='\[\e[41m\]'         # Red
On_Green='\[\e[42m\]'       # Green
On_Yellow='\[\e[43m\]'      # Yellow
On_Blue='\[\e[44m\]'        # Blue
On_Purple='\[\e[45m\]'      # Purple
On_Cyan='\[\e[46m\]'        # Cyan
On_White='\[\e[47m\]'       # White

NC='\[\e[m\]' # Color Reset

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

if [ $UID -eq 0 ]; then
	isRoot=$On_Red$BWhite
else
	isRoot=$Purple
fi

PS1="\
$Green┌─\t \
$NC$isRoot\u\
$NC$BBlue ($BYellow\j$BBlue) \
$NC$BBlue\W \
$NC$Black\$(parse_git_branch)\
$NC$Green\n└$NC\\$ "

# ====================== END PS1 ======================

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
