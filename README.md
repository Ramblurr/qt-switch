# Qt Switcher

This utility designed for archlinux users switches between multiple parallel installed 
versions of Qt.

# Usage

source ./qt-switch

# Info

In addition to finding the current qt package from the community repo, it looks for 
installed packages named `qt-stable-*`, which correspond to a version of Qt installed in 
`/opt/qt-stable-*`

The script sets the relevant environment variables, so it must be sourced not executed.

Based on a more complicated and buggy version from https://github.com/friesoft/archlinux-friesoft-qt-switcher/blob/master/qt-switcher