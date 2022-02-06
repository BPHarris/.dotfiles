from os import environ
from os.path import expanduser, join

from atexit import register
from readline import read_history_file, write_history_file, set_history_length


histfile = environ.get('PYTHONHISTFILE', join(expanduser('~'), '.config', 'python_history'))
histlength = environ.get('PYTHONHISTLENGTH', -1)

try:
    read_history_file(histfile)
except FileNotFoundError:
    pass

try:
    set_history_length(int(histlength))
except TypeError:
    set_history_length(-1)

register(write_history_file, histfile)

