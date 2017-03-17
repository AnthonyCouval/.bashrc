# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi



# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions



alias ll='ls -l --color'
alias d='docker'
alias c='docker-compose'


export EDITOR='vim'
export PAGER='most'
export HISTTIMEFORMAT="%c "
export HISTCONTROL="ignoreboth"
export TERM='xterm-256color'


export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="git auto"
export GIT_PS1_DESCRIBE_STYLE="branch"


if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
	source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

if [ -f /etc/bash_completion.d/git-prompt ]; then
	source /etc/bash_completion.d/git-prompt
fi

if [ -f ~/.local/bin/tmuxinator.bash ]; then
	source ~/.local/bin/tmuxinator.bash
fi




FOREG__BLACK="\[\e[0;30m\]"
FOREG__RED="\[\e[0;31m\]"
FOREG__GREEN="\[\e[0;32m\]"
FOREG__BROWN="\[\e[0;33m\]"
FOREG__BLUE="\[\e[0;34m\]"
FOREG__PURPLE="\[\e[0;35m\]"
FOREG__CYAN="\[\e[0;36m\]"
FOREG__LIGHT_GREY="\[\e[0;37m\]"
FOREG__DEFAULT="\[\e[0;39m\]"

FOREG__GRAY="\[\e[1;30m\]"
FOREG__LIGHT_RED="\[\e[1;31m\]"
FOREG__LIGHT_GREEN="\[\e[1;32m\]"
FOREG__YELLOW="\[\e[1;33m\]"
FOREG__LIGHT_BLUE="\[\e[1;34m\]"
FOREG__LIGHT_PURPLE="\[\e[1;35m\]"
FOREG__LIGHT_CYAN="\[\e[1;36m\]"
FOREG__WHITE="\[\e[1;37m\]"

BACKG__RED="\[\e[41m\]"
BACKG__GREEN="\[\e[42m\]"
BACKG__YELLOW="\[\e[43m\]"
BACKG__BLUE="\[\e[44m\]"
BACKG__MAGENTA="\[\e[45m\]"
BACKG__CYAN="\[\e[46m\]"
BACKG__LIGHT_GREY="\[\e[47m\]"
BACKG__DEFAULT="\[\e[49m\]"

TEXT__BOLD="\[\e[1m\]"
TEXT__UNDERLINE="\[\e[4m\]"
TEXT__BLINK="\[\e[5m\]"
TEXT__INVERSE="\[\e[7m\]"
TEXT__NORMAL="\[\e[m\]"



function make_prompt {
	STOP_COLORS="${FOREG__DEFAULT}${BACKG__DEFAULT}"

	if [ ${UID} -eq 0 ]; then
		PROMPT_COLOR="${FOREG__BLACK}${BACKG__RED}"
	else
		PROMPT_COLOR=$STOP_COLORS
	fi

	read load1m load5m load15m rest < /proc/loadavg
	calc_load=$(echo -e "scale=0 \n $load1m/0.01 \nquit" | bc)

	if [ $calc_load -lt 500 ]; then
		load_color=$FOREG__LIGHT_BLUE
	else
		if [ $calc_load -lt 1000 ]; then
			load_color=$FOREG__GREEN
		else
			if [ $calc_load -lt 1500 ]; then
				load_color=$FOREG__YELLOW
			else
				load_color=$FOREG__RED
			fi
		fi
	fi
	
	__git_ps1 "\n${PROMPT_COLOR}\u@\h${STOP_COLORS} ${load_color}${load1m}${STOP_COLORS} \w" " \\$ " " %s"
}

PROMPT_COMMAND=make_prompt
