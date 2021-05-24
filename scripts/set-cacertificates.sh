#!/bin/bash

# Author Danny
# Version GIT: 2021-05-24 15:29

# set-cacertificates.sh 
# Add the certificates to the local certificate store
# 
# Compatible with: centos, php

echo -e "Starting ${0}"
echo -e "\e[32mConfiguring ca certificates...\e[0m"

if hash "update-ca-trust" 2>/dev/null
then # CentOS/RHEL
  certcmd="update-ca-trust"
  certpath="/etc/share/pki/ca-trust-source/anchors/"
else
  certcmd="update-ca-certificates"
  certpath="/usr/local/share/ca-certificates/" 
fi 

# Create folder for certificates
[[ -d "${certpath}" ]] || mkdir -p "${certpath}"

# Add the /certificates/ (build or run)
shopt -s nullglob
for f in /certificates/*.crt
do 
  cp ${f} ${certpath}/ || exit 1
done

# Add the CACERT_FILE_* (ci/cd)
while IFS='=' read -r name value ; do
  if [[ $name == 'CACERT_FILE_'* ]]
  then
    echo "Adding extra CA certificate: ${value}"
    newname=$(basename $value)
    cp "${value}" "${certpath}${newname,,}.crt" || exit 1 
  fi
done < <(set)

# Import added certificates
if [[ -d "${certpath}" ]] && [[ -n `ls -A "${certpath}"` ]]
then
    echo "Update CA certificates"
    $certcmd || exit 2
fi

echo -e "\e[32mDone\e[0m"