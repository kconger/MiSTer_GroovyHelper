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


freset="\e[0m\033[0m"
fblue="\e[1;34m"
fgreen="\e[1;32m"
fred="\e[1;31m"
fyellow="\e[1;33m"

REPOSITORY_URL="https://raw.githubusercontent.com/kconger/MiSTer_GroovyHelper/"
REPO_BRANCH="master"

SCRIPTNAME="/tmp/update_groovyhelper_script.sh"
NODEBUG="-q -o /dev/null"

echo -e "\n +---------------+";
echo -e " | ${fyellow}GroovyHelper${freset} |";
echo -e " +---------------+\n";

check4error() {
  case "${1}" in
    0) ;;
    1) echo -e "${fyellow}wget: ${fred}Generic error code.${freset}" ;;
    2) echo -e "${fyellow}wget: ${fred}Parse error---for instance, when parsing command-line options, the .wgetrc or .netrc..." ;;
    3) echo -e "${fyellow}wget: ${fred}File I/O error.${freset}" ;;
    4) echo -e "${fyellow}wget: ${fred}Network failure.${freset}" ;;
    5) echo -e "${fyellow}wget: ${fred}SSL verification failure.${freset}" ;;
    6) echo -e "${fyellow}wget: ${fred}Username/password authentication failure.${freset}" ;;
    7) echo -e "${fyellow}wget: ${fred}Protocol errors.${freset}" ;;
    8) echo -e "${fyellow}wget: ${fred}Server issued an error response.${freset}" ;;
    *) echo -e "${fred}Unexpected and uncatched error.${freset}" ;;
  esac
  ! [ "${1}" = "0" ] && exit "${1}"
}

# Update the updater if neccessary
wget ${NODEBUG} --no-cache "${REPOSITORY_URL}${REPO_BRANCH}/mister/update_groovyhelper.sh" -O /tmp/update_groovyhelper.sh
check4error "${?}"
cmp -s /tmp/update_groovyhelper.sh /media/fat/Scripts/update_groovyhelper.sh
if [ "${?}" -gt "0" ] && [ -s /tmp/update_groovyhelper.sh ]; then
    echo -e "${fyellow}Downloading Updater-Update ${fmagenta}${PICNAME}${freset}"
    mv -f /tmp/update_groovyhelper.sh /media/fat/Scripts/update_groovyhelper.sh
    exec /media/fat/Scripts/update_groovyhelper.sh
    exit 255
else
    rm /tmp/update_groovyhelper.sh
fi

# Check and update INI files if neccessary
wget ${NODEBUG} --no-cache "${REPOSITORY_URL}${REPO_BRANCH}/mister/groovyhelper/groovyhelper-system.ini" -O /tmp/groovyhelper-system.ini
check4error "${?}"
. /tmp/groovyhelper-system.ini
[[ -d "${GROOVYHELPER_PATH}" ]] || mkdir "${GROOVYHELPER_PATH}"
cmp -s /tmp/groovyhelper-system.ini "${GROOVYHELPER_PATH}/groovyhelper-system.ini"
if [ "${?}" -gt "0" ]; then
    mv /tmp/groovyhelper-system.ini "${GROOVYHELPER_PATH}/groovyhelper-system.ini"
    . "${GROOVYHELPER_PATH}/groovyhelper-system.ini"
fi

! [ -e /media/fat/groovyhelper/groovyhelper-user.ini ] && touch /media/fat/groovyhelper/groovyhelper-user.ini

wget ${NODEBUG} --no-cache "${REPOSITORY_URL}${REPO_BRANCH}/mister/update_groovyhelper_script.sh" -O "${SCRIPTNAME}"
check4error "${?}"
[ -s "${SCRIPTNAME}" ] && bash "${SCRIPTNAME}" "${1}"
[ -f "${SCRIPTNAME}" ] && rm "${SCRIPTNAME}"

exit 0
