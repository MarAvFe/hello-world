Linux Tips
===

## GIT

#### Definir modo de push simple, para desactivar la pregunta en consola
`git config --global push.default=simple`

#### Log sencillo con hash, nombre del autor y comentario del commit
```
# uso:
#   $ git klog
#   eb5bf14 Administrator: Update HoundSMS.md
#   7858ad9 Administrator: Update HoundSMS.md
#   b9931f7 Marcello: Retorno de consulta y actualizacion actualizados.
#   3640d41 Marcello: delete images from gitignore
#   cda5215 Marcello: smallfix
```

#### Pretty format
```
git config --global alias.klog '!git log -5 --pretty=format:"%h %an: %s"'

%h      %an       %s
eb5bf14 UserName: Commit raw description
```

#### Pretty Format (search)
Log sencillo con un parámetro de búsqueda dentro de los archivos que se hayan agregado en los commits
```
git config --global alias.klogs '!git klog -S'

git klogs "unPatronCon espacios"
```

#### Status corto
`git config --global alias.sta 'status -s'`

#### Pretty Format (tree)
```
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# 7001a2b - (origin/readme-edits) Initial commit (3 years, 5 months ago) <MarAvFe>
```

#### Aliases by Bash
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
