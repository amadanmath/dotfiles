layout_poetry() {
  local venv_path

  if ! venv_path=$(poetry env info --path 2>/dev/null)
  then
    echo '⚠️ No Poetry virtualenv found. Run `poetry install` first, then `direnv reload`.' >&2
    return
  fi
  
  layout python "$venv_path/bin/python"
}
