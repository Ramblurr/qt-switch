#!/bin/bash
#
# Script to switch between various installed Qt versions
#
# usage: source qt-switch.sh
#
# Author: Casey Link <casey.link@kdab.com>
# Author: Bernhard Friedreich (friesoft)
#
# Copyleft 2009, 2011

check_installations()
{
    qt_versions=()

    default_path=`pacman -Q | grep -E "^qt "`
    if [ ! -n "$default_path" ]; then
        echo "No default Qt installation found in /usr"
    else
        echo "Found Qt version $default_path in /usr"
        qt_versions=("${qt_versions[@]}" default)
    fi

    parallel_stable=`pacman -Qq | grep -E "^qt-stable*"`
    if [ -n "$parallel_stable" ]; then
        echo -e "Found the following stable Qt versions installed in parallel:"
        echo $parallel_stable
        qt_versions=("${qt_versions[@]}" $parallel_stable)
    fi
}

prompt_user() {
    echo
    PS3='Select Qt Version: '
    select version in ${qt_versions[@]}
    do
        echo
        break
    done

}

switch_version() {

    if [ $version == "default" ]; then
        qttargetversion="Default path (/usr)"
        export PATHSAVE="$PATH"
        export LDSAVE="$LD_LIBRARY_PATH"
        export QTDIR="/usr"
        export PATH="$QTDIR/bin:$PATHSAVE"
        export LD_LIBRARY_PATH="$QTDIR/lib:$LDSAVE"
    else
        qttargetversion="$version"
        export PATHSAVE="$PATH"
        export LDSAVE="$LD_LIBRARY_PATH"
        export QTDIR="/opt/$version"
        export PATH="$QTDIR/bin:$PATHSAVE"
        export LD_LIBRARY_PATH="$QTDIR/lib:$LDSAVE"
    fi
    echo "Switched to $qttargetversion"
}

if [[ $BASH_SOURCE == $0 ]]; then
    printf 'usage: source %s\n' "$BASH_SOURCE"
    exit 1
fi

check_installations
prompt_user
switch_version
