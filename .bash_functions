######################################################
# FUNCTIONS
######################################################

extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Function to run upon exit of shell.
# function _exit()
# {
#     echo -e "${BRed}Hasta la vista, Baby! ${NC}"
# }
# trap _exit EXIT


# Creates an archive (*.tar.gz) from given directory.
maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

# Print
dum() {
    du --block-size=M -d 1 | sort -n
}

# shortcut for proxy toggling
toggleProxy(){
  if [ -z $http_proxy ] ; then
    export http_proxy='http://10.10.40.15:3225'
    export https_proxy='https://10.10.40.15:3225'
  else
    export http_proxy=''
    export https_proxy=''
  fi
}

# shorcut for `grep 'pattern' * -rn`
# Search pattern in all files and folders recursiveli within pwd
# and print it's appearance and line number
grephere(){
    if [ -z $2 ] ; then
        pattern=$1
        shift
        grep $pattern * -rn --exclude-dir=node_modules $@
    else
        grep $1 * -rn --exclude-dir=node_modules
    fi
}

# Supress command output and send it to background
nout(){
    $@ &> /dev/null &
}

# Fallback trash bin with log of deletions
rm(){
    mkdir ~/.trashbin &> /dev/null
    for beep in "$@"
    do
        echo "rm $beep from $PWD" >> ~/.trashbin/trashbin.log
        mv "$beep" ~/.trashbin
    done
}

# Colorize man pages
_colorman() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;35m") \
    LESS_TERMCAP_md=$(printf "\e[1;34m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[7;40m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;33m") \
    "$@"
}
man() { _colorman man "$@"; }
