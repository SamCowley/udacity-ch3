#!/bin/bash
for file in built/*; do
    docker push samcowley/$file
done
