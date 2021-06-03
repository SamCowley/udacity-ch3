#!/bin/bash

if grep -q '&all' <<< "${TRAVIS_COMMIT_MESSAGE}"; then
    CHANGED_DIRECTORIES="$(ls | cut -d'/' -f1 | sort | uniq | grep 'service')"
else
    COMMIT_RANGE="$(echo ${TRAVIS_COMMIT_RANGE} | cut -d '.' -f 1,4 --output-delimiter '..')"
    CHANGED_FILES="$(git diff --name-only ${COMMIT_RANGE} --)"
    CHANGED_DIRECTORIES="$(echo "$CHANGED_FILES" | cut -d'/' -f1 | sort | uniq | grep 'service')"
fi

echo "=========================================="
sed 's/^/Staged: /g' <<< "$CHANGED_DIRECTORIES"
echo "=========================================="

mkdir -p built

for DIR in $CHANGED_DIRECTORIES; do
    NAME="udacity-ch3-$(echo "$DIR" | cut -d'-' -f1)"
    echo "=========================================="
    echo "Building: $NAME"
    echo "=========================================="
    pushd $DIR &> /dev/null
        docker build -t $NAME .
        docker tag $NAME samcowley/$NAME:latest
    popd &> /dev/null
    touch built/$NAME
done
