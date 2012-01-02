#!/bin/sed -nf

#
/^Change \([[:digit:]]\+\)/ b change
# else:
p
n

# \033 = Escape
# [31 foreground color?
: change
s/^Change \([0-9]\+\) on \([0-9/: ]\+\) by \([a-z]\+\)@.*$/\o33[31;32m\1 \o33[31;33m\3 \o33[31;37m\2/g
p
