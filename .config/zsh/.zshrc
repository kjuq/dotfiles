# Lines configured by zsh-newuser-install
HISTFILE="$XDG_CONFIG_HOME/.histfile"
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Disable ESC
function do-nothing() {}
zle -N do-nothing
bindkey '^[' do-nothing
KEYTIMEOUT=1

# Not Exit with Ctrl-D
setopt ignoreeof

bindkey \^U backward-kill-line

WORDCHARS='-'

# Alias {{{

alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

alias la='ls --almost-all'
alias lla='ll --almost-all'
alias l1='ls -1'

case "$(uname)" in
	Linux)
		alias ls='ls --color=auto --classify --group-directories-first'
		alias open='xdg-open'
		;;
	Darwin)
		alias ls='ls -GF'
		;;
esac

if type nvim &> /dev/null; then
	alias Nvim='env KJUQ_NVIM_NO_EXT_PLUGINS=1 nvim'
	alias nvimt='nvim +EditDashboard'
	alias nvimr='nvim +EditReponotes'
	alias nvimd='nvim +EditDailynote'
fi

if type ghq &> /dev/null; then
	alias ghf='repo="$(ghq list | fzf)" && cd "$(ghq root)/$repo"'
fi

if type trash &> /dev/null; then
	alias dl='command trash -r'
	alias rm='command echo "rm is dangerous so use dl instead.'
fi

if type w3m &> /dev/null; then
	alias w3m='env TERM=xterm-256color command w3m'
fi

# }}}

# if type zoxide &> /dev/null; then
# 	eval "$(zoxide init --cmd c zsh)"
# fi

_kjuq_fresh_session=true

precmd() {
	# New line handling (not on first prompt)
	if [[ "$_kjuq_fresh_session" = "false" ]]; then
		print ""
	fi
	printf "\r\033[K"
	_kjuq_fresh_session=false

	if [[ $? -ne 0 ]]; then
		prompt_status="%F{red}[$?]%f"
	fi

	# SSH user@hostname
	local user_and_hostname=""
	if [[ -n "$SSH_CONNECTION" ]]; then
		user_and_hostname=" %n@%m"
	fi

	# Build prompt
	# %~ = current directory (like dirs in fish)
	# %F{8} = bright black (gray)
	# %f = reset color
	cr=$'\n'
	PROMPT="%f%~%F{8}${user_and_hostname}%f ${prompt_status}${cr}%F{8}$ %f"
	# PROMPT="$(dirs -p | head -n1)
# %F{244}$ %f"
}

# }}}

# Plugins {{{
# `pacman -S zsh-syntax-highlighting`
if [ -e /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
if [[ -e /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi
# }}}

# vim: set foldmethod=marker :
