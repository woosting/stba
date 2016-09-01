#! /bin/bash
# # STart BAckup
#
# A startup script for [StoreBackup](http://storebackup.org/) (the temarkable
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

  SOURCEDIR="${HOME}/.storeBackup/sources"
  TARGETDIR="${HOME}/.storeBackup/target/link2target"  # Assuming the target dir contains a link ("link2target") to point to the real target.
  LINKS2SOURCES="y"                                    # Assuming the sources dir contains links to point to the (possibly various) sources.
# >>> NOTE: THE AFOREMENTIONED SETTINGS OVERRULE THEIR EQUIVALENTS IN A SUPPLIED CONFIGURATION! <<<
  CONFIGFILE="${HOME}/.storeBackup/storeBackup.cfg"    # Rest is taken from the config file if supplied (otherwise storeBackup configs are used).


# INITIALISATION

  while getopts s:t:l:c: option; do  #CL-INTAKE (flagged arguments)
    case "${option}"
     in
       s) SOURCEDIR=(${OPTARG});;
       t) TARGETDIR=(${OPTARG});;
       l) LINKS2SOURCES=(${OPTARG});;
       c) CONFIGFILE=(${OPTARG});;
       *) 
          echo -e "Usage: [-c /path/configfile] [-s /path/sourcedir] [-t /path/targetdir] [-l n|y|Y|yes|Yes|YES]."
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

  dire ${SOURCEDIR}${L2SSUPPL} ${TARGETDIR} && \
  dirp ${SOURCEDIR}${L2SSUPPL} ${TARGETDIR} && \
  echo -e "storeBackup.pl --sourceDir ${SOURCEDIR} --backupDir ${TARGETDIR} ${L2SDEPTH} -f ${CONFIGFILE}"
