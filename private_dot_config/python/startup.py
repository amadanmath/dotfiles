import os
import sys

try:
    from rich import pretty
    pretty.install()
    del pretty
except Exception:
    # Probably an ImportError, but we simply ignore any exception.
    from pprint import pp
