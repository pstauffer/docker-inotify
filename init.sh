#!/bin/sh

#
# Script options (exit script on command fail).
#
set -e


export

curl --unix-socket /var/run/docker.sock http:/containers/json

echo "[DONE]"
