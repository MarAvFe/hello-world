Linux Tips
===

## GIT

#### Definir modo de push simple, para desactivar la pregunta en consola
`git config --global push.default=simple`

### Log sencillo con hash, nombre del autor y comentario del commit
```
# uso:
#   $ git klog
#   eb5bf14 Administrator: Update HoundSMS.md
#   7858ad9 Administrator: Update HoundSMS.md
#   b9931f7 Marcello: Retorno de consulta y actualizacion actualizados.
#   3640d41 Marcello: delete images from gitignore
#   cda5215 Marcello: smallfix

git config --global alias.klog '!git log -5 --pretty=format:"%h %an: %s"'

%h      %an       %s
eb5bf14 UserName: Commit raw description
```

### Pretty Format (search)
Log sencillo con un parámetro de búsqueda dentro de los archivos que se hayan agregado en los commits
```
git config --global alias.klogs '!git klog -S'

git klogs "unPatronCon espacios"
```

### Status corto
`git config --global alias.sta 'status -sb'`

#### Listar conflictos
conflicts = !git ls-files -u | cut -f 2 | sort -u
`git config --global alias.conflicts '!git ls-files -u | cut -f 2 | sort -u'`

### Pretty Format (tree)
```
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# 7001a2b - (origin/readme-edits) Initial commit (3 years, 5 months ago) <MarAvFe>
```

### Aliases by Bash
```Bash
alias gitlog="git log --color --graph --pretty=format:'%Cgreen[%Creset%h%Cgreen]%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gittoday="git log --color --graph --pretty=format:'%Cgreen[%Creset%h%Cgreen]%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --since=yesterday"
alias commit='git commit'
alias gb='git branch -v'
alias gc='git commit -m'
alias gt='git commit -m "typo"'
alias ga='git add '
alias gd='git diff'
alias gr='git rm'
alias gs='git status'
alias gss='git status -s'
alias gpl='git pull origin'
alias gush='git push origin'
alias gco='git checkout'
alias amend='git commit --amend'
```

### Clone repository without .git history
```Bash
git clone --depth 1 https://github.com/CocoaPods/Specs
```

### Commits per user
```Bash
git config --global alias.who '!echo "== Commits by Author:\n`git shortlog -s -n`\n"'
```

## Linux - Ubuntu

### Colorize term title
```sh
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt

force_color_prompt=yes # Uncomment this line

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi
```

### Listing files
```sh
alias ll='ls -alFh' # Hidden files, long description, classify type, human readable
alias la='ls -A'    # Almost all
alias lh='ls -lah'  # Long, all, human
alias l='ls -CF'    # Columns, classify type
alias lr='ls -lrS'  # long, reverse, Size
```

### Colorize cat output
```sh
sudo apt install python-setuptools
sudo easy_install Pygments

alias cat="pygmentize -g"
```

### To know disk space remaining
```sh
df -h .
```

### Analysis of running processes
[htop](http://hisham.hm/htop/) is an enhanced top with extra features
```sh
htop

top
```

### Summary of uptime
```sh
$ uptime

12:48:09 up  4:15,  1 user,  load average: 1,51, 1,41, 1,32
# time right now
# uptime hh:mm
# connected users in the moment
# Load average on processors last 1, 5, 15 minutes.
#     Each number is the load of the N processors on that moment.
#     This example shows 75% load on computer because it has 2 processors.
```

### Get the path of a program
```sh
which ls
alias which='type -a'
$which ls
```

### Find files and folders
```sh
$ find <DIRECTORY> -name <FILENAME>
```

## Vim

### Multiple files simultaneously
```sh
$ find <DIRECTORY> -name <FILENAME>
vim -p file1.go file2.go # Multiple tabs
vim -o file1.go file2.go # Split window horizontally
vim -O file1.go file2.go # Split window vertically

# To switch amost tabs of screens: Ctrl+w hjkl
```

### Unminify JS with vim
Into .vimrc
```vim
" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction
```
Then open file and call like
```sh
vim file1.md
:UnMinify
```



### Reference
- [Linux and Shell Basics](https://coderwall.com/p/kubxjq/linux-and-bash-shell-basics)
- [Reference .bashrc](https://github.com/bt3gl/Dotfiles-and-Bash-Examples/blob/master/configs/bashrc)
- [Scripting refs](https://coderwall.com/p/teggxa/bash-shell-script-quick-cheat-sheet)
