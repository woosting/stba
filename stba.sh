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

  TARGETDIR="${HOME}/.storeBackup/target/link2target"  # Assuming the target dir contains a link ("link2target") to point to the real target.
  SOURCEDIR="${HOME}/.storeBackup/sources"
  LINKS2SOURCES="y"                                    # Assuming the sources dir contains links to point to the (possibly various) sources.
# ^^^ NOTE: THE AFOREMENTIONED SETTINGS OVERRULE THEIR EQUIVALENTS IN A SUPPLIED CONFIGURATION! vvv
  CONFIGFILE="${HOME}/.storeBackup/storeBackup.cfg"    # Rest is taken from the config file, if supplied (otherwise storeBackup configs are used).


# INITIALISATION

  if [ "${LINKS2SOURCES}" == "y" ] || [ "${LINKS2SOURCES}" == "Y" ] || [ "${LINKS2SOURCES}" == "yes" ] || [ "${LINKS2SOURCES}" == "Yes" ] || [ "${LINKS2SOURCES}" == "YES" ] ; then
    L2SSUPPL="/*"
    L2SDEPTH="--followLinks 1"
  else
    L2SSUPPL=""
    L2SDEPTH="--followLinks 0"
  fi


# EXECUTION

  dirp -v -e -r "${SOURCEDIR}${L2SSUPPL}" -w "${TARGETDIR}" && \
  echo -e "storeBackup.pl --sourceDir ${SOURCEDIR} --backupDir ${TARGETDIR} ${L2SDEPTH} -f ${CONFIGFILE}"
