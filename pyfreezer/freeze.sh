#!/bin/bash

./Python-3.8.1/python -m pip install -r $(dirname $1)/requirements.txt
./Python-3.8.1/python ./Python-3.8.1/Tools/freeze/freeze.py -p ${PWD}/Python-3.8.1 -e ${PWD}/ext -o build "$@"
cd build && make && cd -
cp build/$(basename $1 .py) $(dirname $1)
echo "Earliest supported glibc:"
readelf --syms build/$(basename $1 .py) | grep GLIBC_ | cut -d@ -f2 | cut -d_ -f2 | cut -d' ' -f1 | sort -V | tail -1
echo "ldd:"
ldd build/$(basename $1 .py)
