# https://docs.python.org/3/library/readline.html?highlight=readline#example
import atexit
import os
import readline

histfile = os.path.join(os.environ["XDG_STATE_HOME"], "python/history")
histpath = os.path.split(histfile)[0]

if not os.path.exists(histpath):
    os.makedirs(histpath)
try:
    readline.read_history_file(histfile)
except FileNotFoundError:
    pass
# Default history len is -1 (infinite), which may grow unruly.
readline.set_history_length(1000)
# Prevent creation of default history if custom is empty.
if readline.get_current_history_length() == 0:
    readline.add_history("# dummy text")

atexit.register(readline.write_history_file, histfile)
