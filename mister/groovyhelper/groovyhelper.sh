#!/bin/sh
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# You can download the latest version of this script from:
# https://github.com/kconger/MiSTer_GroovyHelper

#
# groovyhelper service
#

. /media/fat/groovyhelper/groovyhelper-system.ini
. /media/fat/groovyhelper/groovyhelper-user.ini

# Debug function
dbug() {
  if [ "${DEBUG}" = "true" ]; then
    if [ ! -e ${DEBUGFILE} ]; then                                           # log file not (!) exists (-e) create it
      echo "---------- GroovyHelper Debuglog ----------" > ${DEBUGFILE}
    fi 
    echo "${1}" >> ${DEBUGFILE}                                              # output debug text
  fi
}

# Send Core GIF image over the web
senddata() {
  CORE=${1}
  dbug "GroovyHelper checking CORENAME"
  case $CORE in
    "GroovyMAME")
      dbug "Requesting GroovyMAME on ${HOSTNAME}"
      ssh ${USERNAME}@${HOSTNAME} -tt ${MAME_START_CMD}
      ;;
    "MENU")
      dbug "Killing GroovyMAME on ${HOSTNAME}"
      ssh ${USERNAME}@${HOSTNAME} -tt ${MAME_STOP_CMD}
    ;;
    *)
      dbug "Unknown Groovy Core: ${1}"
      ;;
  esac     
}

while true; do                                                                # main loop
  if [ -r ${CORENAMEFILE} ]; then                                             # proceed if file exists and is readable (-r)
    NEWCORE=$(cat ${CORENAMEFILE})                                            # get CORENAME
    echo "Read CORENAME: -${NEWCORE}-"
    dbug "Read CORENAME: -${NEWCORE}-"
    if [ "${NEWCORE}" != "${OLDCORE}" ]; then                                 # proceed only if Core has changed
      senddata "${NEWCORE}"                                                   # The "Magic"
      OLDCORE="${NEWCORE}"                                                    # update oldcore variable
    fi                                                                        # end if core check
    if [ "${DEBUG}" = "false" ]; then
      # wait here for next change of corename, -qq for quietness
      inotifywait -qq -e modify "${CORENAMEFILE}"
    fi
    if [ "${DEBUG}" = "true" ]; then
      # but not -qq when debugging
      inotifywait -e modify "${CORENAMEFILE}"
    fi
  else                                                                        # CORENAME file not found
   echo "File ${CORENAMEFILE} not found!"
   dbug "File ${CORENAMEFILE} not found!"
  fi                                                                          # end if /tmp/CORENAME check
done
# ** End Main **
