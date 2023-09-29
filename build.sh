#!/bin/bash

if [ $# -gt 0 ]; then BLOCKCHAIN_NODE_VERSION=$1; shift; fi
if [ $# -gt 0 ]; then echo "syntax: $0 [<BLOCKCHAIN_NODE_VERSION>]"; exit 1; fi

IMAGE_NAME="bitcoin-core"
echo $IMAGE_NAME
docker build --platform linux/amd64 -t $IMAGE_NAME:v25.0 --build-arg BLOCKCHAIN_NODE_VERSION=$BLOCKCHAIN_NODE_VERSION .
