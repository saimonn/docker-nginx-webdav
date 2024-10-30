#!/usr/bin/env bash

if [ -n "$IMAGE_NAME" ] ;then
  echo "Err: empty variable 'IMAGE_NAME'"
fi

docker build -t $IMAGE_NAME .
