# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
PATH="${PATH}:${HOME}/.local/bin:${HOME}/bin"

export PS1='[$(date +%j%H%M) \u@\h \W]\$ '

# Mail user from-address
export from='kwhalen2@kent.edu'
export FROM="${from}"

# Text editors
export VISUAL=vim
export EDITOR=vim
export SVN_EDITOR=vim

# Bash eternal history.
# stackoverflow.com/q/9457233/
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Certain bash sessions truncate .bash_history file upon close.
# superuser.com/q/575479/
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# superuser.com/q/20900/
export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"

# AMD ROCm and OpenCL
PATH="${PATH}:/opt/rocm/bin:/opt/rocm/opencl/bin/x86_64"


export PATH
