layout_uv() {
  local python_version="$1"
  local venv_dir="${2:-.venv}"

  if [ ! -d "$venv_dir" ]; then
    echo "direnv: creating uv venv ($python_version) at $venv_dir"

    if [ -n "$python_version" ]; then
      uv venv --python "$python_version" "$venv_dir"
    else
      uv venv "$venv_dir"
    fi
  fi

  source "$venv_dir/bin/activate"

  # Optional: auto-install deps
  if [ -f pyproject.toml ]; then
    echo "direnv: syncing dependencies with uv"
    uv sync
  fi
}
