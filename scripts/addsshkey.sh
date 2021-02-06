#!/bin/bash

# Adding SSH private key
if [ ! -z "$SSH_PRIVATE_KEY" ]
then
    echo "Adding ssh private key to ssh-agent"
    echo "Warning: must be launched as '. addsshkey.sh' !"
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