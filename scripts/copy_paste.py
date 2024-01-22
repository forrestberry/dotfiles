# Copy/paste to/from the clip board.
import sys
import subprocess

def paste():
    '''Returns the contents of the clipboard.'''
    return subprocess.check_output('pbpaste', env={'LANG':
                                           'en_US.UTF-8'}).decode('utf-8')

def copy(output):
    '''Writes the argument to the clipboard.'''
    process = subprocess.Popen(
    'pbcopy', env={'LANG': 'en_US.UTF-8'}, stdin=subprocess.PIPE)
    process.communicate(output.encode('utf-8'))

