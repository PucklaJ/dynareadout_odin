#! /bin/sh

set -e

echo Building C library ...
xmake config -P lib/dynareadout --build_cpp=n
xmake -P lib/dynareadout

echo Building binout example ...
examples/binout/build.sh
echo Building d3plot example ...
examples/d3plot/build.sh
