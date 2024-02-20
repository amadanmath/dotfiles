ired="$(tput setaf 9)"
igreen="$(tput setaf 10)"
iyellow="$(tput setaf 11)"
iblack="$(tput setaf 8)"
off="$(tput sgr0)"

# See https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html
__prompt_command() {
  local last_exit="$1"
  local git_part=""
  local prompt
  local nested_prompt=""
  local prompt_color
  local i

  if [ "$last_exit" -eq 0 ]
  then
    prompt_color="$igreen"
  else
    prompt_color="$ired"
  fi

  if git branch &>/dev/null
  then
    local branch="$(git symbolic-ref HEAD 2>/dev/null)"
    local git_color

    if [ -n "$branch" ]; then
      branch=" (${branch##refs/heads/})"
    fi

    if git diff-index --quiet HEAD 2>/dev/null
    then
      git_color="$igreen"
    else
      git_color="$ired"
    fi

    git_part="\[$git_color\]$branch\[$off\]"
  fi
  export PS1="\[$iblack\]\h:\[$iyellow\]\w$git_part \[$prompt_color\]$SHLVL\[$iblack\]!\!\[$off\] \$ "
}
export PROMPT_COMMAND='__prompt_command $? '
