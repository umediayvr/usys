#!/bin/bash

# standby happens after 60 minutes and screen turns off after 2 hours:
# the first numerical argument is for standby, the second is for suspend,
# and third is the off setting (the current configuration can be queried
# via "xset -q")
xset dpms 3600 0 7200
