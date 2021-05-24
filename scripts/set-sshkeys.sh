#!/bin/bash

# Author Danny
# Version GIT: 2021-05-24 15:29

# set-sshkeys.sh
# set the SSH key for gitlab use

echo -e "Starting ${0}"
echo -e "\e[32mConfiguring ssh key...\e[0m"

# Adding SSH private key
if [ ! -z "$SSH_PRIVATE_KEY" ]
then
    echo "Adding ssh private key to ssh-agent"
    #echo "Warning: must be launched as '. addsshkey.sh' !"
    eval $(ssh-agent -s)
    echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add - > /dev/null
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    ssh-keyscan gitlab.com >> ~/.ssh/known_hosts
    ssh-keyscan github.com >> ~/.ssh/known_hosts
    chmod 644 ~/.ssh/known_hosts
    # [[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
else
    echo "No SSH_PRIVATE_KEY present"
fi

echo -e "\e[32mDone\e[0m"