#!/usr/bin/python3
# Fabfile to delete outdated archives
import os
from fabric.api import *

env.hosts = ['52.90.0.73','34.234.201.81']

def do_clean(number=0):
    """ Deletes outdates archives, keeps the most and second
    most recent archives """
    number = 1 if int(number) == 0 else int(number)
    archives = sorted(os.listdir("versions"))
    [archives.pop() for i in range(number)]
    with lcd("versions"):
        [local("rm ./{}".format(a)) for a in archives]

    with cd("/data/web_static/releases"):
        archives = run("ls -tr").split()
        archives = [a for a in archives if "web_static_" in a]
        [archives.pop() for i in range(number)]
        [run("rm -rf ./{}".format(a)) for a in archives]
