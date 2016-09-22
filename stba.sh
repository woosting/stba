#! /bin/bash
# # STart BAckup
#
# A startup script for [StoreBackup](http://storebackup.org/) (the remarkable
# GNU backup program written by: Heinz-Josef Claes).
#
# Copyright 2016 Willem Oosting
#
# >This program is free software: you can redistribute it and/or modify
# >it under the terms of the GNU General Public License as published by
# >the Free Software Foundation, either version 3 of the License, or
# >(at your option) any later version.
# >
# >This program is distributed in the hope that it will be useful,
# >but WITHOUT ANY WARRANTY; without even the implied warranty of
# >MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# >GNU General Public License for more details.
# >
# >You should have received a copy of the GNU General Public License
# >along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# FORK ME AT GITHUB: https://github.com/woosting/stba


# CONFIGURATION

  SOURCEDIR="${HOME}/.storeBackup/sources"             # Assuming the sources dir countains symbolic links that point to the real sources directories.
  LINKS2SOURCES="y"                                    # Assuming the sources dir contains links to point to the (possibly various) sources.
  TARGETDIR="${HOME}/.storeBackup/target/target.ln"    # Assuming the target dir contains a symbolic link, "target.ln", that points to the real target directory.
# ^^^ NOTE: THE AFOREMENTIONED SETTINGS OVERRULE THEIR EQUIVALENTS IN A SUPPLIED CONFIGURATION! vvv
  CONFIGFILE="${HOME}/.storeBackup/storeBackup.cfg"    # Rest is taken from the config file, if supplied (otherwise storeBackup configs are used).


# INITIALISATION

  PATH=${PATH}:/usr/local/bin

  while getopts s:l:t:c: option
  do
    case "${option}"
     in
       s) SOURCEDIR=${OPTARG};;
       l) LINK2SOURCES=${OPTARG};;
       t) TARGETDIR=${OPTARG};;
       c) CONFIGFILE=${OPTARG};;
       *) echo -e "Usage: [-s \"/path/sourcedir\"] [-l y|n ] [-t \"/path/target\"] [-c \"/path/configfile\"]\nUsing (some) defaults instead."
    esac
  done

  if [ "${LINKS2SOURCES}" == "y" ] || [ "${LINKS2SOURCES}" == "Y" ] || [ "${LINKS2SOURCES}" == "yes" ] || [ "${LINKS2SOURCES}" == "Yes" ] || [ "${LINKS2SOURCES}" == "YES" ] ; then
    L2SSUPPL="/*"
    L2SDEPTH="--followLinks 1"
  else
    L2SSUPPL=""
    L2SDEPTH="--followLinks 0"
  fi


# EXECUTION

  dirp -v -e -r "${SOURCEDIR}${L2SSUPPL}" -w "${TARGETDIR}" && \
  storeBackup.pl --sourceDir ${SOURCEDIR} --backupDir ${TARGETDIR} ${L2SDEPTH} -f ${CONFIGFILE}
