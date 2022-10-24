#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Append "$1" to $PATH when not already in.
append_path () {
	case ":$PATH:" in
		*:"$1":*)
			;;
		*)
			PATH="${PATH:+$PATH:}$1"
	esac
}

append_path "$HOME/.local/bin"
append_path "$HOME/.cargo/bin"

# Unload our profile API functions
unset -f append_path

# Some useful alises
alias la='ls -a'

# Environment variables for NVM(Node Version Manager)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Oh My Posh
eval "$(oh-my-posh init bash --config ~/.poshthemes/the-unnamed.omp.json)"
