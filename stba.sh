#! /bin/bash
# # STart BAckup
#
# A startup script for [StoreBackup](http://storebackup.org/) (a remarkable
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

  CONFIGFILE="${HOME}/.storeBackup/storeBackup.cfg"
  SOURCEDIR="${HOME}/.storeBackup/sources"
  TARGETDIR="${HOME}/.storeBackup/target"
  LINK2DIR="y"


# INITIALISATION

  while getopts c:s:t:l: option; do  #CL-INTAKE (flagged arguments)
    case "${option}"
     in
       c) CONFIGFILE=(${OPTARG});;
       s) SOURCEDIR=(${OPTARG});;
       t) TARGETDIR=(${OPTARG});;
       l) LINK2DIR=(${OPTARG});;
       *) echo -e "Usage: [-c /path/configfile] [-s /path/sourcedir] [-t /path/targetdir] [-l y|n]."
    esac
  done
  if [ "${LINK2DIR}" == "y" ] || [ "${LINK2DIR}" == "Y" ]; then
    SUPPLEMENT="/*"
  fi


# EXECUTION

  dire ${SOURCEDIR}${SUPPLEMENT} ${TARGETDIR} && \
  dirp ${SOURCEDIR}${SUPPLEMENT} ${TARGETDIR} && \
  storeBackup.pl --sourceDir ${SOURCEDIR} --backupDir ${TARGETDIR} -f ${CONFIGFILE}
