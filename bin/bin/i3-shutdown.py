#!/usr/bin/env python3

from gi.repository import i3ipc
from subprocess import call

def  on_shutdown(conn):
    call(["ssh-add", "-D"])
    call(["ssh-agent", "-k"])

