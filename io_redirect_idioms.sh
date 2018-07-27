#!/bin/bash -x

##########################################################################################
# Understand stdout and stderr redirection idioms like below 
# ls foo > /dev/null 2>&1
# 
# Reference link: https://www.brianstorti.com/understanding-shell-script-idiom-redirect/
#
# Author:
#  Ruifeng Ma <ruifengm@sg.ibm.com>
# Date:
#  2018-Jul-27
##########################################################################################


CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# <<< Unstand file descriptors >>>
# In unix systems, everything is a file. A file descriptor is a positive integer that represents an open 
# file. 1 is reserved for stdour and 2 for stderr by the system. 
# <<< Unstand file descriptors >>>

# Redirect stdout to a file
# Note that > is a shorthand for 1>, the redirecting syntax is [FILE_DESCRIPTOR]>
ls $CUR_DIR > dir_list.txt
cat dir_list.txt
rm -f dir_list.txt
# sleep 3

# Redirect strerr to a file
cat dir_list 2> error.txt
cat error.txt
rm -f error.txt

# Redirect stderr to stdout
# &[FILE_DESCRIPTOR] is a reference to the value of the FILE_DESCRIPTOR, 
# hence 2>&1 means "redirecting stderr to the same place where stdout goes"
cat dir_list 2>&1

# Redirect both stdout and stderr to a file
cat dir_list > output.txt 2>&1
cat output.txt
rm -f output.txt

# No redirection
# (echo STDOUT && echo STDERR >&2) is a sub-shell
(echo STDOUT && echo STDERR >&2)

# Redirect stdout and stderr to respective files
(echo STDOUT && echo STDERR >&2) > STDOUT.txt 2> STDERR.txt
cat STDOUT.txt
cat STDERR.txt
rm STDOUT.txt 
rm STDERR.txt

# Redirect both stdout and stderr to /dev/null
(echo STDOUT && echo STDERR >&2) >/dev/null 2>&1
(echo STDOUT && echo STDERR >&2) 2>/dev/null 1>&2

# Redirect stdout to /dev/null and stderr to stdout
(echo STDOUT && echo STDERR >&2) 2>&1 >/dev/null

echo -e "End of script."