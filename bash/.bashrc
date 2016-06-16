# Basic variables
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

# SSH known hosts
: ${HOSTFILE=~/.ssh/known_hosts}

# Config for readline
: ${INPUTRC=~/.inputrc}

# -----------------------------------------------------------------------------
# Options for shell
# -----------------------------------------------------------------------------

# If system-wide bashrc exists, bring it in
test -r /etc/bash.bashrc &&
      . /etc/bash.bashrc

# notify of background job completion immediately
set -o notify

# Explanation of used shell options:
# cdspell - autocorrect minor errors in cd path
# extglob - enable extended pattern matching
# histappend - append to HISTFILE insteead of overriding
# hostcomplete - if readline used, bash will attempt to complete hostnames
# interactive_comments - if line in prompt begins with #, treat as comment
# mailwarn - warning when mail file accessed
# no_empty_cmd_completion - don't attempt to search path for completion if
# empty line
shopt -s cdspell                  >/dev/null 2>&1
shopt -s extglob                  >/dev/null 2>&1
shopt -s histappend               >/dev/null 2>&1
shopt -s hostcomplete             >/dev/null 2>&1
shopt -s interactive_comments     >/dev/null 2>&1
shopt -u mailwarn                 >/dev/null 2>&1
shopt -s no_empty_cmd_completion  >/dev/null 2>&1

# disable core dumps
ulimit -S -c 0

# set umask
umask 0022

# -----------------------------------------------------------------------------
# Environment configuration
# -----------------------------------------------------------------------------

# detect interactive shell
case "$~" in
  *i*)  INTERACTIVE=yes ;;
  *)    unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
  -*) LOGIN=yes ;;
  *)  unset LOGIN ;;
esac

# set en_US locale with utf-8
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# use PASSIVE ftp mode
: ${FTP_PASSIVE:=1}
export FTP_PASSIVE

# ignore python bytecode, vim swap files
FIGNORE=".pyc:.swp:.swa:.swo"

# history related variables
export HISTCONTROL=ignoreboth
export HISTFILESIZE=50000
export HISTSIZE=50000
export HISTIGNORE='ls:bg:fg:history'
export PROMPT_COMMAND='history -a'

# -----------------------------------------------------------------------------
# Pager/editor settings
# -----------------------------------------------------------------------------

HAVE_GVIM=$(command -v gvim)
HAVE_VIM=$(command -v vim)

# editor
test -n "$HAVE_VIM" &&
EDITOR=vim ||
EDITOR=vi
export EDITOR

# pager
if test -n "$(command -v less)"; then
  PAGER="less -FirSwX"
  MANPAGER="less -FirSwX"
else
  PAGER=more
  MANPAGER=more
fi

if test -n "$HAVE_VIM"; then
        export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
fi

# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------

# load color codes
test -r ~/.bash/color_codes &&
      . ~/.bash/color_codes

# set colors according to username
if [ "$LOGNAME" = "root" ]; then
  COLOR1="${RED}"
  COLOR2="${PURPLE}"
  P="#"
else
  COLOR1="${YELLOW}"
  COLOR2="${PURPLE}"
  P="\$"
fi

prompt_simple() {
  
  unset PROMPT_COMMAND
  PS1="[\u@\h:\w] ${P} "
  PS2="${P} "

}

jobscount() {
	local stopped='$(jobs -s | wc -l | tr -d " ")'
	local running='$(jobs -r | wc -l | tr -d " ")'
	echo -n "${running}r/${stopped}s"
	 }

prompt_color() {

	PS1="${BLUE}[${GREEN}\t${BLUE}][${YELLOW}\u${GREY}@${PURPLE}\h${GREY}:${CYAN}\W${BLUE}][${RED}\j${BLUE}]${BROWN}$P${PS_CLEAR} "
  PS2="${P} "

}

# -----------------------------------------------------------------------------
# Ls and dircolors
# -----------------------------------------------------------------------------

# always passed to ls
LS_COMMON="-hBG"

# if dircolors tool available, set it up
dircolors="$(type -P gdircolors dircolors | head -1)"

# -----------------------------------------------------------------------------
# Bash completion
# -----------------------------------------------------------------------------

for f in /usr/local/etc/bash_completion/* \
              /etc/bash_completion/* \
              ~/.bash/completion/*
do
  
  if [ -f $f ]; then
    . $f
  fi
done

# override and disable tilde expansion
_expand() {
return 0
}

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

for f in ~/.bash/aliases/*
do
  if [ -f $f ]; then
    . $f
  fi
done

# -----------------------------------------------------------------------------
# Proxy related functions
# -----------------------------------------------------------------------------

function proxy_on() {

  export http_proxy=$proxy
  export https_proxy=$proxy
  export ftp_proxy=$proxy
  export rsync_proxy=$proxy
  return 0

}

function proxy_off() {

  unset http_proxy
  unset https_proxy
  unset ftp_proxy
  unset rsync_proxy

}

# -----------------------------------------------------------------------------
# Archive extracting function
# -----------------------------------------------------------------------------

extract () {
   if [ -f $1 ] ; then
      case $1 in
         *.tar.bz2)   tar xjf $1      ;;
         *.tar.gz)   tar xzf $1      ;;
         *.bz2)      bunzip2 $1      ;;
         *.rar)      rar x $1      ;;
         *.gz)      gunzip $1      ;;
         *.tar)      tar xf $1      ;;
         *.tbz2)      tar xjf $1      ;;
         *.tgz)      tar xzf $1      ;;
         *.zip)      unzip $1      ;;
         *.Z)      uncompress $1   ;;
         *)         echo "'$1' cannot be extracted via extract()" ;;
      esac
   else
      echo "'$1' is not a valid file"
   fi
}

# -----------------------------------------------------------------------------
# Personal configuration
# -----------------------------------------------------------------------------

# load shenv file - personal configuration

test -r ~/.bash/shenv &&
      . ~/.bash/shenv
