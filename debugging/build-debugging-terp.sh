#! /bin/bash

pushd remglk
make
popd

pushd Git
gcc -g -I../remglk accel.c git.c heap.c operands.c saveundo.c compiler.c memory.c peephole.c search.c gestalt.c git_unix.c glkop.c opcodes.c savefile.c terp.c -L../remglk -lremglk -o remgit
popd

sed 's|\$DEBUGGING_DIR|'$(pwd)'|g' sleepgit.template > sleepgit
chmod 755 sleepgit
