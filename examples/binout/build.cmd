@echo off

odin build ./examples/binout -out:binout.exe "-extra-linker-flags=-libpath:build\windows\x64\release"
