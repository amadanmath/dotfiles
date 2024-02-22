# Thanks to https://codeberg.org/scy/dotfiles/src/commit/467547d976cf09a67a7ca583185adb52d6978173/.config/python-repl-init.py

import os
import sys

try:
    from rich import pretty
    pretty.install()
    del pretty
except Exception:
    # Probably an ImportError, but we simply ignore any exception.
    from pprint import pp
