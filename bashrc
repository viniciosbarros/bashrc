# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export TERM=xterm-256color

#set the umask value
#umask 002

# Global variables:
LAST_DIR=~

#Sets an alternative procedure to 'cd ../../..' just shoot '....' adding a . makes a jump backward
#sudo wget http://www.fvue.nl/cdots/cdots-1.2.1.txt
#cp cdots-1.2.1.txt ~/.cdots-1.2.1.sh && /bin/rm -f cdots-1.2.1.txt
if [ -e ~/.cdots-1.2.1.sh ]; then
	source ~/.cdots-1.2.1.sh
else
	echo "Quer instalar cdots?"
fi

#echo "Let me stand next to your fire" | cowsay -f dragon

USUARIO="vinicios.silva"
SENHA=""

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias gmake=make
    alias remove="sudo apt-get remove"
    alias get="sudo apt-get install"
    alias apt-get="sudo apt-get install"
    alias inst="sudo apt-get install"
    alias aptitude="sudo apttitude install"
    alias psegrep="ps -e | grep"
    alias ..='cd ..'
    alias baxa="sudo apt-get install"
    alias cata="sudo aptitude search"
    alias seteth0="sudo ifconfig eth0:29 192.168.29.80 netmask 255.255.255.0 up"
    alias rmm="rm"
    alias gofrank="ssh acesso@192.168.20.151"
    alias processo='ps -aux | grep '
    alias kila='sudo kill -9 '
    alias finish='sudo killall '
    alias youtube='youtube-dl -c -t'
#   alias rm="mv -t ~/.local/share/Trash/files "
fi

###
###some more ls aliases
###
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias gmake=make
alias make=colormake
###############################################################################################
###############################################################################################
###############################################################################################
###################################Begin Of Funtions###########################################
###############################################################################################
###############################################################################################
###############################################################################################
function cd() { LAST_DIR=`pwd`; builtin cd $1; ls; }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function back() { builtin cd $LAST_DIR ; ls; }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function chmod()
{
if [ "$#" -eq 1 ]; then
	echo "rwxrwxrwx?"
	read VAL
	for ARG in $*; do
		/bin/chmod $VAL $ARG
		/bin/ls -lsa $ARG
	done
else
	/bin/chmod $*
	/bin/ls -lsa $2
fi
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#function aguaquente() # Start a timer to check warming of water for tea
# {
#	if [ $# -ne 0 -o -z $1 ]; then
#		sleep $1
#		echo "AGUA QUENTE" | osd_cat -p middle -A center -c red --font=-*-*-*-*-*-*-*-290-*-*-*-*-iso8859-* -O 5 -d 2
#	else
#		echo " "
#		echo " 'Agua Quente' Is a bash function to create a countdown in seconds"
#		echo " Usage:"
#		echo "   $ aguaquente  <Time> "
#	fi
# }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function cherami() # Send file using nc and cat
{
VAL=2
	if [ $# -ne 2 -o -z $1 ]; then
		/bin/cat $1 | /bin/nc $2 $3
		VAL=$?
	else
		echo " "
		echo " 'Cher Ami' Is a bash function to help send of a text file using nc program"
		echo " Usage:"
		echo "   $ cherami  <fileToSend>  <serverIP>  <port> "
	fi
	if [ $VAL -eq 1 ]; then
		echo " "
		echo "ERROR: [$VAL] "
		echo "      Check your fucking connection ..."
		echo " "
	elif [ $VAL -eq 0 ]; then
		echo " "
		echo " OK! Check your file at server"
		echo " "
	fi
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function lstm() #list some lines of mail file
{
    tail -n 50 /var/mail/$(whoami)
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function headquarter() # Receive text file using nc and cat
{
	if [ $# -ne 1 -o -z $1 ]; then
		echo " waiting ..."
		/bin/nc -l $2 >> $1
		echo " " 
		echo " ... done"
	else
		echo "ERROR:"
		echo " Try: "
		echo "   headquarter  <fileToReceive>  <port> "
	fi
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function ipl() # Get IP adresses.
{
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    /sbin/ifconfig | awk '/inet/ { print $2 } ' | sed -e s/addr:// | sed '/^$/d'
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function snn() # Set IP in a new net
{
	if [ -z $1 ]; then
		echo "ERROR:"
		echo " Try: "
		echo "   snn  <networkAlias> "
	else
		sudo /sbin/ifconfig eth0:$1 192.168.$1.80
	fi
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function rm()
{
	if [ -e ~/.local/share/Trash/files ]; then
		mv -t ~/.local/share/Trash/files $@
		echo "Enviado para lixeira"
	else
		echo "Lixeira nao encontrada. Deseja Criar? [y/n]"
		read option
		if [ $option = "y" ]; then
			mkdir -p ~/.local/share/Trash/files
		else
			echo "Duvidas? Verifique o bashrc"
		fi

	fi

}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function lixeira()
{
	ls -l ~/.local/share/Trash/files
} 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
canopener()
{
    for file in "$@"
    do
        if [ -f "$file" ]
        then
            case "$file" in
                *.tar.bz2|*.tbz2) tar xvjf "$file";;
                *.tar.gz|*.tgz) tar xvzf "$file";; 
				*.tar.xz) tar xvf "$file";;
				*.bz2) bunzip2 "$file";;
                *.rar) rar x "$file";;
                *.gz) gunzip "$file";;
                *.tar) tar xvf "$file";;
                *.zip) unzip "$file";;
                *.Z) uncompress "$file";;
                *.7z) 7z x "$file";;
                *) echo "Sorry bro! I don't know how to expand this '$file'...";;
            esac || echo "File $file is corrupted"
        else
            echo "'$file' is not valid!"
        fi
    done
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function tempoloko()
{
declare -a WEATHERARRAY
echo " "
lynx -dump "http://tempo.folha.com.br/rs/porto_alegre/" | grep -A 5 -m 1 "TEMPO AGORA"
#echo ${WEATHERARRAY[@]}
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function nota()
{
	if [ ! -d ~/.notas ]; then
	mkdir ~/.notas
	fi
	touch ~/.notas/"$*"
	echo "nota armazenada para ler todas: lernotas"
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function lernotas()
{
	echo "------------NOTAS--------------"
	ls -lt ~/.notas
	echo "----------FIM DAS NOTAS--------"
	echo " para escrever notas: nota exemplo de nota"
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function real()
{
	`which $1` $2
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function final_frontier()
{
  if [ ! -z $1 ]; then
    du -sh $1/* | sort -hr
    echo "TOTAL -----------"
    du -sh $1
  else echo "ERROR in USE: correct is: final_frontier /dir/subdir , pay attention to sudo dirs"
  fi
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function monta()
{

date=`date +"%d%m%y%M%S"`

  if [ ! -z $1 ]; then
    mkdir /mnt/tmp_${date}
    mount $1 /mnt/tmp_${date}
    nautilus /mnt/tmp_${date}
    umount /mnt/tmp_${date}
  else echo "ERROR in USE: correct is: monta /dev/sdX , pay attention to sudo command"
  fi
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function encFpg()
{
	gpg --symmetric --cipher-algo aes256 -o $1.gpg $1
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function decFpg()
{
	gpg -d $1 | tar xzvf -
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function indent_knf()
{
    indent -bap -br -ce -ci4 -cli0 -d0 -di0 -i8 -ip 0 -l79 -nbc -ncdb -ndj -nfc1 -nlp -npcs -psl -sc -sob $1
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Quite interresting auto-complete for SSHing :D
# host names already in the bash history
complete -W "$(echo $(grep '^ssh ' ~/.bash_history | sort -u | sed 's/^ssh //'))" ssh
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function au()
{
	echo "ALL BASHRC FUNCTIONS:"
	echo " "
	echo "  cd                     Same command like always but will show files in the respective directory"
	echo "  chmod                  If you forgot to pass the chmod value, it will wait for it."
	echo "  aguaquente <T>         An mental note will pop in T segundos"
	echo "  cherami <x> <y> <z>    Sends one file through your LAN, works with headquarter cmd"
	echo "  headquarter <y> <z>    Receives one file from LAN, works with cherami cmd"
	echo "  ip                     Shows all configured IPs"
	echo "  snn <param>            Creates an alias for ethernet names, the param will be the network."
	echo "  rm                     Fake rm, this one executes a move of file to .Trash. see cmd: real rm"
	echo "  canopener <param>      Expands any type of compacted file"
	echo "  tempoloko              Checks the local weather"
	echo "  nota <param>           Creates a mental note with text of param"
	echo "  lernotas               Just reads all saved notes"
	echo "  real <param>           Invokes the real program without aliases, or bash's functions"
	echo "  final_frontier <param> Calculates the amount SPACE of the param dirs and subdirs in 1st level"
	echo "  monta <param>          mount device in param "
    echo "  encFpg <tar-file>  Encrypt tar file"
	echo "  decFpg <tar-file>  Dencrypt tar file"
}
# http://www.tempoagora.com.br/previsaodotempo.html/brasil/PortoAlegre-RS/
###############################################################################################
###############################################################################################
###############################################################################################
###################################End Of Funtions#############################################
###############################################################################################
###############################################################################################
###############################################################################################

########################################################################
# LICENSES PARA AS FERRAMENTAS DE CAD
########################################################################
export MGLS_LICENSE_FILE=27004@naxos.inf.pucrs.br
export CCSS_KEYS=27000@naxos.inf.pucrs.br
export SNPSLMD_LICENSE_FILE=27000@naxos.inf.pucrs.br
export XILINXD_LICENSE_FILE=2100@naxos.inf.pucrs.br

############################################
# INCLUSAO DAS FERRAMENTAS NO PATH #
############################################
export PATH=$PATH:/soft/modeltech/bin
#source /opt/Xilinx/11.4/settings32.sh
export PATH=$PATH:/sbin

###########################################
# modificações de configuração do shell
###########################################
export PS1='\u@\h:\w\$ '
alias konsole='konsole --schema xtermm.schema'
PS1='\[\e[7;7m\]\u@\h:\w\[\e[K\e[0m\]\n'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

###########
#Rapid Alias
###########
alias cpsmoketofrank='scp -r Smoke/ acesso@192.168.20.151:./Smoke'
alias diane='cd ~/elinux/diane' 
alias bashrc=' vim ~/.bashrc' 
alias vazari='exit'
alias rmtglock='export DISPLAY=:0 && gnome-screensaver-command -l'
alias rmtxlock='export DISPLAY=:0 && xlock'
alias enableapproves="sudo mv /home/vinicios/Documents/meme/Bryan_Approves.png /var/www/approves"
alias enabledisapproves="sudo mv /home/vinicios/Documents/meme/Bryan_Meme.png /var/www/disapproves"
alias disableapproves="sudo rm /var/www/approves"
alias disabledisapproves="sudo rm /var/www/disapproves"
alias bc="bc -l"
alias xkcd="~/Dropbox/scripts/get_comics/pull-xkcd/pull_xkcd.sh"
alias cyanide="~/Dropbox/scripts/get_comics/pull-xkcd/pull_cyanide.sh"
alias dilbert="~/Dropbox/scripts/get_comics/pull-xkcd/pull_dilbert.sh"
alias aguaquente="/home/vinicios/Dropbox/scripts/timerCook/timer.sh"
