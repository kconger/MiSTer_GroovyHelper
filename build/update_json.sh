#!/bin/bash
#https://github.com/MiSTer-devel/Downloader_MiSTer/blob/main/docs/custom-databases.md

MD5=$(md5sum ../mister/update_groovyhelper.sh | awk '{print $1}')
SIZE=$(ls -o ../mister/update_groovyhelper.sh | awk '{print $4}')
DATE=$(gdate +%s -r ../mister/update_groovyhelper.sh)
cp groovyhelperdb.json-empty groovyhelperdb.json
gsed -i 's/"hash": "XXX"/"hash": "'${MD5}'"/' groovyhelperdb.json
gsed -i 's/"size": XXX/"size": '${SIZE}'/' groovyhelperdb.json
gsed -i 's/"timestamp": XXX/"timestamp": '${DATE}'/' groovyhelperdb.json
mv groovyhelperdb.json ../
