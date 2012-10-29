###### COLORS ######
 txtblk='\e[0;30m' # Black - Regular
 txtred='\e[0;31m' # Red
 txtgrn='\e[0;32m' # Green
 txtylw='\e[0;33m' # Yellow
 txtblu='\e[0;34m' # Blue
 txtpur='\e[0;35m' # Purple
 txtcyn='\e[0;36m' # Cyan
 txtwht='\e[0;37m' # White
 bldblk='\e[1;30m' # Black - Bold
 bldred='\e[1;31m' # Red
 bldgrn='\e[1;32m' # Green
 bldylw='\e[1;33m' # Yellow
 bldblu='\e[1;34m' # Blue
 bldpur='\e[1;35m' # Purple
 bldcyn='\e[1;36m' # Cyan
 bldwht='\e[1;37m' # White
 unkblk='\e[4;30m' # Black - Underline
 undred='\e[4;31m' # Red
 undgrn='\e[4;32m' # Green
 undylw='\e[4;33m' # Yellow
 undblu='\e[4;34m' # Blue
 undpur='\e[4;35m' # Purple
 undcyn='\e[4;36m' # Cyan
 undwht='\e[4;37m' # White
 bakblk='\e[40m'   # Black - Background
 bakred='\e[41m'   # Red
 badgrn='\e[42m'   # Green
 bakylw='\e[43m'   # Yellow
 bakblu='\e[44m'   # Blue
 bakpur='\e[45m'   # Purple
 bakcyn='\e[46m'   # Cyan
 bakwht='\e[47m'   # White
 txtrst='\e[0m'    # Text Reset

parse_git_branch () 
{ 
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf " $txtred|$bldylw%s$txtred|" "${b##refs/heads/}";
    fi
}


###### EXPORTS ######
#####################

export PATH=/opt/local/bin:/opt/local/bin:/opt/local/sbin:$PATH

export EDITOR=/usr/bin/vim   #default editor. could be pico, nano, vim, or emacs
# export HISTFILESIZE=3000            #size of command history
export HISTCONTROL=ignoredups       #ignore duplicates in history

export PATH="$HOME/bin:$PATH"
source ~/bin/git-completion.bash

###### Basic Aliases ######
###########################

#list with colors, omit dots, long format, and / after directory
alias ll='ls -AlGF'

#list with --more---                     
alias lm='ls -AlF | more'
               
#same as ll but sort by size
alias lz='ls -AlGFSr'                   

#dir nugs
alias dir='ls -AlGF'

#crazy graphical view of subdirs. It's neat, but don't use it in directories with many children
alias lg="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"

#override the 'link' command so it automatically creates symlinks
alias link='ln -sf'

#creates intermediate directories by default
alias mkdir='mkdir -p'             

#if you change directories into a symbolic link, type this to switch to absolute path 
alias cdfix='cd `pwd -P`'               

#edits this file
alias editprof='edit ~/.bash_profile'

#reloads profile after editing this file  
alias runprof='. ~/.bash_profile'

#type "hist [arg]" to search all previous commands that contain arg        
alias hist='history | grep $1'

#"pss [arg]" shows all running proccess that contain arg          
alias pss='ps aux | grep'

#ping stop at 3, like windows               
alias ping='ping -c 3'                  

#returns the size of a file in human readable format. If performed on a directory, includes size of all children directories
alias ds='du -sh'

#makes a file executable to all users                    
alias exe='chmod a+x'                   	

#edit a file in the default editor
alias edit='open -a /Applications/TextMate.app'                   

#lowercase all files in the current directory
alias lowerfiles='for file in *; do mv $file $(echo $file | tr [[:upper:]] [[:lower:]]); done'

#system-wide removal of all those stupid .DS_Store files created by finder. 
alias killdsstore='sudo find / -name ".DS_Store" -depth -exec rm {} \;'
 
#usage: ruhere [search_string] #searches current dir and all sub-dirs for arg. returns full path!
alias ruhere='find $PWD | grep' 

###### Misc. Scripts ######
###########################

#passphrase encrypt a file. 
encrypt()
{
    if [ -z "$1" ];
    then
        echo "usage: encrypt infile [outfile]"
    else
        if [ $# -gt 1 ]; then
            OUTFILE="$2"
        else
            OUTFILE="enc_$1"
        fi
        openssl rc4 -salt -in $1 -out $OUTFILE
    fi
}

#corresponding decryption
decrypt()
{
    if [ -z "$1" ];
    then
        echo "usage: decrypt infile [outfile]"
    else
        if [ $# -gt 1 ]; then
            OUTFILE="$2"
        else
            OUTFILE="dec_$1"
        fi
        openssl rc4 -d -salt -in $1 -out $OUTFILE
    fi
}

# Setting PATH for Python 3.2
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.2/bin:${PATH}"
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Prompt
export PS1="(\A) $txtgrn\w\$(parse_git_branch) $txtgrn\$$txtrst " 