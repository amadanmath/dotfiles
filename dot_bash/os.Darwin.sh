# VSCode
[[ -x "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code" ]] &&
  alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

# Movie players
#alias vlc=/Applications/VLC.app/Contents/MacOS/VLC
[[ -x "/Applications/DJV2.app/Contents/MacOS/DJV2" ]] &&
  alias djv=/Applications/DJV2.app/Contents/MacOS/DJV2

[[ -d "/opt/homebrew" ]] &&
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"


# Apple TTS
alias sayko="say -v Yuna"
alias sayjp="say -v Kyoko"
alias saych="say -v Ting-Ting"

sshmount() {
  remote="$1"
  mountpoint="$2"
  if [[ -z "$mountpoint" ]]
  then
    mountpoint=$(basename "$remote")
  fi
  sshfs "$remote" "$mountpoint" -o auto_cache,reconnect,defer_permissions,noappledouble,allow_other
}
