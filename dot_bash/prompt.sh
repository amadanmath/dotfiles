__prompt_ired="$(tput setaf 9)"
__prompt_igreen="$(tput setaf 10)"
__prompt_iyellow="$(tput setaf 11)"
__prompt_iblack="$(tput setaf 8)"
__prompt_off="$(tput sgr0)"

# See https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html
__prompt_command() {
  local soh=$'\x01'
  local stx=$'\x02'
  local last_exit="$1"
  local git_color


  if [ "$last_exit" -eq 0 ]
  then
    __prompt_exit_color="$__prompt_igreen"
  else
    __prompt_exit_color="$ired"
  fi

  if git branch &>/dev/null
  then
    local branch="$(git symbolic-ref HEAD 2>/dev/null)"

    if [ -n "$branch" ]; then
      branch=" (${branch##refs/heads/})"
    fi

    if git diff-index --quiet HEAD 2>/dev/null
    then
      git_color="$__prompt_igreen"
    else
      git_color="$__prompt_ired"
    fi

    __prompt_git="$soh$git_color$stx$branch$soh$__prompt_off$stx"
  else
    __prompt_git=""
  fi
}
export PROMPT_COMMAND='__prompt_command $? '
export PS1='\[$__prompt_iblack\]\h:\[$__prompt_iyellow\]\w$__prompt_git \[$__prompt_exit_color\]$SHLVL\[$__prompt_iblack\]!\!\[$__prompt_off\] \$ '
