bindkey "\e[3~" delete-char
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey ';5D' backward-word # ctrl+left
bindkey ';5C' forward-word #ctrl+right

autoload -U compinit promptinit
compinit
promptinit;

if [[ $EUID == 0 ]]
then
	PROMPT=$'%{\e[1;31m%}%n %{\e[1;34m%}%~ #%{\e[0m%} ' # user dir %
else
	PROMPT=$'%{\e[1;32m%}%n %{\e[1;34m%}%~ %#%{\e[0m%} ' # root dir #
fi
RPROMPT=$'%{\e[1;34m%}%T%{\e[0m%}' # right prompt with time

alias ls='ls -G'
alias grep='grep --colour=auto'

