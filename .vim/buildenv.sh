#!/bin/sh
# generate tag and cscope.out file

ctags -R `pwd`
find `pwd` -name "*.c" -o -name "*.h" -o -name "*.cpp" > cscope.files
cscope -bR -i cscope.files
