#!/bin/bash

###########################################################################
#                                                                         #
#  FILE     : lock_tty.sh                                                 #
#  AUTHOR   : Nam Nguyen     <gdbtek@yahoo.com>                           #
#  CREATED  : 01/01/1999                                                  #
#  UPDATED  : 11/22/2001                                                  #
#  FLATFORMS: Unix/Linux/Mac only.                                        #
#  PURPOSE  : This locktty script is similar to the lock command on       #
#             Berkeley UNIX. It can keep people from using your terminal  #
#             while you are away from it for short periods of time. It    #
#             saves you from having to log out if you are concerned       #
#             about other users using your login.                         #
#  COMMENT  : Feel free to distribute/modify the codes to fit your        #
#             personal needs as long as the comment boxes remain intact.  #
#                                                                         #
###########################################################################

clear
echo
printf '                         \033[7m                           \033[0m\n'
printf '                         \033[7m   LOCK TERMINAL PROGRAM   \033[0m\n'
printf '                         \033[7m                           \033[0m\n'
echo
echo
echo

IFS="^M"
stty -echo
trap "stty echo; echo; echo; exit" INT

echo -n 'Enter a key: '
read key1

if [ "$key1" = '' ]
then
    echo
    echo
    echo "Input at least one character!"
else
    echo
    echo
    echo -n 'Re-enter: '
    read key2
    echo
    echo

    if [ "$key1" = "$key2" ]
    then
        trap '' 1 2 3 9 15 18 24

        stty -isig
        stty stop ''

        echo 'LOCKED SUCCESSFULLY'
        echo
        echo -n 'Enter the key: '
        read key3

        while [ "$key3" != "$key2" ]
        do
            printf '\07'
            read key3
        done

        echo

        stty stop "^S"
        stty isig

        trap - 1 2 3 9 15 18 24
    else
        printf '\07'
        echo 'Keys do not match!'
    fi
fi

echo
stty echo
