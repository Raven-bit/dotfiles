# This is the file used by zsh's interactive login. Interacty stuff goes here.

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt 'Assuming %e errors:'
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/${USER}/.zshrc'

autoload -Uz compinit
autoload -U colors
colors
compinit

# We have to set this explicitly
bindkey '^R' history-incremental-search-backward

# ANSI escape codes for setting xterm-ish titlebars.
_thing1=$'\e]0;'
_thing2=$'\a'

# If we're root, lets be "bright" about it, ha, ha, ha.
_setspacer()
{
        case ${USER} in
                root)
                        _spacer='%{%F{red}%}#%{%f%}'
                        ;;
                *)
                        _spacer="$"
                        ;;
        esac
}

# These don't carry through su -; root will need a .zshrc as well.
# But they do carry through su now that I did it right.
autoload -Uz add-zsh-hook
add-zsh-hook precmd _setspacer


# Exported variables go here.
# export PS1="%{${_thing1}%* %n@%m: ~% ${_thing2}%}[%* %{$fg[green]%}${STY##*.}%{%b%} %n@%m:%~]%{${_spacer}%G%} "
export PS1='%{${_thing1}%* %n@%m: ~% ${_thing2}%}[%* %F%{$fg[green]%}${STY##*.} %n@%m%f:%F%{$fg[yellow]%}%~%f]${_spacer} '

# If we're about to run a command.... Set the title bar
preexec() { printf "${_thing1}%s${_thing2}" "${1}"; }

# Aliases in general go here.
alias ls="ls --color=auto -a"
