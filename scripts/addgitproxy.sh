#!/bin/bash

# Adding PROXY to git
if [ ! -z "$HTTP_PROXY" ]
then
    echo "Configuring $HTTP_PROXY in git"
    git config --global http.proxy $HTTP_PROXY
fi
if [ ! -z "$HTTPS_PROXY" ]
then
    echo "Configuring $HTTPS_PROXY in git"
    git config --global https.proxy $HTTP_PROXY
fi
if [ -z "$HTTPS_PROXY" ] && [ -z "$HTTP_PROXY" ]
then
    echo "No HTTP_PROXY set"
fi
# git config --global http.sslVerify false