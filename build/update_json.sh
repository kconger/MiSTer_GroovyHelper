#!/bin/bash
#https://github.com/MiSTer-devel/Downloader_MiSTer/blob/main/docs/custom-databases.md
INSTALLER_MD5=$(md5sum ../mister/groovyhelper/install_groovyhelper.sh | awk '{print $1}')
INSTALLER_SIZE=$(ls -o ../mister/groovyhelper/install_groovyhelper.sh | awk '{print $4}')
SCRIPT_MD5=$(md5sum ../mister/groovyhelper/groovyhelper.sh | awk '{print $1}')
SCRIPT_SIZE=$(ls -o ../mister/groovyhelper/groovyhelper.sh | awk '{print $4}')
SCRIPT_DATE=$(gdate +%s -r ../mister/groovyhelper/groovyhelper.sh)
SVC_MD5=$(md5sum ../mister/groovyhelper/S60groovyhelper | awk '{print $1}')
SVC_SIZE=$(ls -o ../mister/groovyhelper/S60groovyhelper | awk '{print $4}')
SYSINI_MD5=$(md5sum ../mister/groovyhelper/groovyhelper-system.ini | awk '{print $1}')
SYSINI_SIZE=$(ls -o ../mister/groovyhelper/groovyhelper-system.ini | awk '{print $4}')
INI_MD5=$(md5sum ../mister/groovyhelper/groovyhelper-user.ini | awk '{print $1}')
INI_SIZE=$(ls -o ../mister/groovyhelper/groovyhelper-user.ini | awk '{print $4}')

cp groovyhelperdb.json-empty groovyhelperdb.json

gsed -i 's/"hash": "YYY"/"hash": "'${INSTALLER_MD5}'"/' groovyhelperdb.json
gsed -i 's/"size": YYY/"size": '${INSTALLER_SIZE}'/' groovyhelperdb.json
gsed -i 's/"hash": "WWW"/"hash": "'${SCRIPT_MD5}'"/' groovyhelperdb.json
gsed -i 's/"size": WWW/"size": '${SCRIPT_SIZE}'/' groovyhelperdb.json
gsed -i 's/"hash": "XXX"/"hash": "'${SVC_MD5}'"/' groovyhelperdb.json
gsed -i 's/"size": XXX/"size": '${SVC_SIZE}'/' groovyhelperdb.json
gsed -i 's/"hash": "YYY"/"hash": "'${SYSINI_MD5}'"/' groovyhelperdb.json
gsed -i 's/"size": YYY/"size": '${SYSINI_SIZE}'/' groovyhelperdb.json
gsed -i 's/"hash": "ZZZ"/"hash": "'${INI_MD5}'"/' groovyhelperdb.json
gsed -i 's/"size": ZZZ/"size": '${INI_SIZE}'/' groovyhelperdb.json

gsed -i 's/"timestamp": XXX/"timestamp": '${SCRIPT_DATE}'/' groovyhelperdb.json

mv groovyhelperdb.json ../
