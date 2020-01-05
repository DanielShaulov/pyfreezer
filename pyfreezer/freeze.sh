#!/bin/bash -e

./pysrc/python -m pip install -r $(dirname $1)/requirements.txt
./pysrc/python ./pysrc/Tools/freeze/freeze.py -p $(realpath pysrc) -e $(realpath ext) -o build "$@"
cp overrides.c build/
export LDFLAGS="overrides.c -Wl,-Bstatic"
cd build && make LIBS="-Wl,-Bdynamic -lrt -lutil -lpthread -ldl" && cd -
cp build/$(basename $1 .py) $(dirname $1)

# Checks
GLIBC_VER=$(readelf --dyn-syms --wide build/$(basename $1 .py) | grep GLIBC_ | cut -d@ -f2 | cut -d_ -f2 | cut -d' ' -f1 | sort -V | tail -1)
echo "Earliest supported glibc: $GLIBC_VER"
readelf --syms build/$(basename $1 .py) | grep GLIBC_${GLIBC_VER}

echo "ldd:"
ldd build/$(basename $1 .py)
