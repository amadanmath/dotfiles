aliases() { $EDITOR ~/.zsh/aliases.zsh && source ~/.zsh/aliases.zsh }

ls --color=auto /dev/null &>/dev/null 2>&1 && alias ls='ls --color=auto'

command -v nvim &>/dev/null && alias vim=nvim

ssh() {
  if [[ -n "$KITTY_PID" ]] && command -v kitten >/dev/null 2>&1; then
    kitten ssh "$@"
  else
    command ssh "$@"
  fi
}

sshcd() {
  local host="${1%:*}"
  local dir="${1#*:}"
  ssh -t "$host" "cd \"$dir\" && exec \$SHELL -li"
}

sshmount() {
  local remote="$1"
  local mountpoint="${2:-$(basename "$remote")}"
  local opts="auto_cache,reconnect,idmap=user,ServerAliveInterval=15,ServerAliveCountMax=3"

  if [[ "$OSTYPE" == darwin* ]]; then
    opts+=",defer_permissions,noappledouble"
  fi

  sshfs "$remote" "$mountpoint" -o "$opts"
}

tunnel() {
  local host="$1"
  local args=()
  shift
  for port in "$@"; do
    args+=(-L "$port":localhost:"$port")
  done
  ssh -N "${args[@]}" -o ServerAliveInterval=60 -o ServerAliveCountMax=3 "$host"
}

_cht_complete() {
  local -a opts
  opts=(${(f)"$(curl -s cheat.sh/:list)"})
  compadd -a opts
}
compdef _cht_complete cht.sh
