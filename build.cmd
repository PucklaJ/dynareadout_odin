@echo off

echo Building C library ...
xmake config -P lib\dynareadout --build_cpp=n
xmake -P lib\dynareadout

echo Building binout example ...
call examples/binout/build.cmd
