#!/bin/bash

./Python-3.8.1/python ./Python-3.8.1/Tools/freeze/freeze.py -p ${PWD}/Python-3.8.1 -e ${PWD}/ext -o build "$@"
cd build && make && cd -
cp build/$(basename $1 .py) $(dirname $1)
