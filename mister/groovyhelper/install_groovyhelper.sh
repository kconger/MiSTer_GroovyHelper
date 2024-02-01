#!/bin/bash
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

! [ -e /media/fat/groovyhelper/groovyhelper-user.ini ] && touch /media/fat/groovyhelper/groovyhelper-user.ini
. /media/fat/groovyhelper/groovyhelper-system.ini
. /media/fat/groovyhelper/groovyhelper-user.ini

echo -e "\n +--------------------------+";
echo -e " | ${fyellow}GroovyHelper Installer${freset} |";
echo -e " +--------------------------+\n";

# Check for and create groovyhelper script folder
[[ -d ${GROOVYHELPER_PATH} ]] && cd ${GROOVYHELPER_PATH} || mkdir ${GROOVYHELPER_PATH}

# Check and remount root writable if neccessary
if [ $(/bin/mount | head -n1 | grep -c "(ro,") = 1 ]; then
  /bin/mount -o remount,rw /
  MOUNTRO="true"
fi

# Enable service to start at boot
if [ ! -e /media/fat/linux/user-startup.sh ] && [ -e /etc/init.d/S99user ]; then
  if [ -e /media/fat/linux/_user-startup.sh ]; then
    echo "Copying /media/fat/linux/_user-startup.sh to /media/fat/linux/user-startup.sh"
    cp /media/fat/linux/_user-startup.sh /media/fat/linux/user-startup.sh
  else
    echo "Building /media/fat/linux/user-startup.sh"
    echo -e "#!/bin/sh\n" > /media/fat/linux/user-startup.sh
    echo -e 'echo "***" $1 "***"' >> /media/fat/linux/user-startup.sh
  fi
fi
if [ $(grep -c "groovyhelper" /media/fat/linux/user-startup.sh) = "0" ]; then
  echo -e "Add groovyhelper to /media/fat/linux/user-startup.sh\n"
  echo -e "\n# Startup GroovyHelper" >> /media/fat/linux/user-startup.sh}
  echo -e "[[ -e ${INITSCRIPT} ]] && ${INITSCRIPT} \$1" >> /media/fat/linux/user-startup.sh
fi

echo -e "${fgreen}GroovyHelper Installed${freset}"

# Check and remount root non-writable if neccessary
[ "${MOUNTRO}" = "true" ] && /bin/mount -o remount,ro /

if [ $(pidof ${DAEMONNAME}) ]; then
  echo -e "${fgreen}Restarting init script\n${freset}"
  ${INITSCRIPT} restart
else
  echo -e "${fgreen}Starting init script\n${freset}"
  ${INITSCRIPT} start
fi

[ -z "${SSH_TTY}" ] && echo -e "${fgreen}Press any key to continue\n${freset}"
