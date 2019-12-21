#!/bin/bash

./Python-3.8.1/python.exe ./Python-3.8.1/Tools/freeze/freeze.py -p ${PWD}/Python-3.8.1 -o build "$@"
cd build && make && cd -
cp build/$(basename $1 .py) $(dirname $1)