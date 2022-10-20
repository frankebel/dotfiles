# https://docs.python.org/3/library/readline.html?highlight=readline#example
import atexit
import os
import readline

histfile = os.path.join(os.environ['XDG_DATA_HOME'], 'python/python_history')
try:
    readline.read_history_file(histfile)
    # default history len is -1 (infinite), which may grow unruly
    readline.set_history_length(1000)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)
