#!/bin/bash
#
# ---------------------------------------------------------------------
# PhpStorm xdg-open startup script.
# example for xdebug.file_link_format option, note the last parameter format: path-on-vagrant-guest>path-on-vagrant-host
# shell script extracts these paths to create the command for phpstorm correctly
# xdebug.file_link_format="phpstorm://open?file=%f&line=%l&/vagrant/>/home/rene/projects/my-project/"
# ---------------------------------------------------------------------
#

if [ ! -z "$1" ]
    then
        [[ $1 =~ ^.*file=(.*)\&line.*$ ]]
        file=${BASH_REMATCH[1]}

        [[ $1 =~ ^.*\&line=([^&]+).*$ ]]
        line=${BASH_REMATCH[1]}

        [[ $1 =~ ^.*\&([^>]+).*$ ]]
        guest=${BASH_REMATCH[1]}
        [[ $1 =~ ^.*\>(.*)$ ]]
        host=${BASH_REMATCH[1]}

        file="${file/$guest/$host}"

        `/usr/local/bin/pstorm --line $line $file`
fi
