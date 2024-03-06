# My dotfiles

These are my dotfiles, managed by [chezmoi](https://www.chezmoi.io/).
Quickstart:

```
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply amadanmath
```

* Install [fd](https://github.com/sharkdp/fd?tab=readme-ov-file#installation). 

  If using a binary release, download from [releases](https://github.com/sharkdp/fd/releases), then unpack. On Linux,

  ```
  mv fd ~/.local/bin/
  mv fd.1 ~/.local/share/man/man1/
  mv autocomplete/fd.bash ~/.local/share/bash-completion/completions/fd.bash
  ```

* Install [ripgrep](https://github.com/BurntSushi/ripgrep).
