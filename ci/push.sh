#!/usr/bin/env bash

if [ -n "$IMAGE_NAME" ] ;then
  echo "Err: empty variable 'IMAGE_NAME'"
fi

docker push $IMAGE_NAME .
