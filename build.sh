#!/bin/bash

COMMIT_RANGE="$(echo ${TRAVIS_COMMIT_RANGE} | cut -d '.' -f 1,4 --output-delimiter '..')"
CHANGED_FILES="$(git diff --name-only ${COMMIT_RANGE} --)"

CHANGED_DIRECTORIES="$(echo "$CHANGED_FILES" | cut -d'/' -f1 | sort | uniq | grep 'service')"

mkdir built

for DIR in $CHANGED_DIRECTORIES; do
    NAME="udacity-ch3-$(echo "$DIR" | cut -d'-' -f1)"
    pushd $DIR
        docker build -t $NAME .
        docker tag $NAME samcowley/$NAME:latest
    popd
    touch built/$NAME
done
