#! /bin/bash

git clone git://github.com/erkyrath/remglk.git
git clone git://github.com/ziz/sleepmask.git
git clone git://github.com/DavidKinder/Git.git

pushd sleepmask
git apply ../sleepmask-remgit.patch
popd

pushd Git
cp ../git_unix.c ./
git apply ../git-pc-tracking.patch
popd
