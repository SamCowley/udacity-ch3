#!/bin/bash
for file in built/*; do
    echo "=========================================="
    echo "Pushing: $(basename $file)"
    echo "=========================================="
    docker push samcowley/$file
done
