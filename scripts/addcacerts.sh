#!/bin/bash

# First add each certificate contents as separate gitlab File variables
certpath="/usr/local/share/ca-certificates/"

# Copy custom CA certificates
while IFS='=' read -r name value ; do
  if [[ $name == 'CACERT_FILE_'* ]]
  then
    echo "Adding extra CA certificate: ${value}"
    newname=$(basename $value)
    cp "${value}" "${certpath}${newname,,}.crt"  
  fi
done < <(set)

# Import added certificates
if [[ -d "${certpath}" ]] && [[ -n `ls -A "${certpath}"` ]]
then
    echo "Update CA certificates"
    update-ca-certificates
fi