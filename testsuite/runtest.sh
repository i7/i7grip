#! /bin/bash

if [ -e build-temp ]
then
    rm -r build-temp
fi
mkdir -p build-temp
mkdir -p build-temp/Source
mkdir -p build-temp/Index
touch build-temp/Index/Headings.xml
mkdir -p build-temp/Build
cp $1 build-temp/Source/story.ni
head -n2 build-temp/Source/story.ni
"$INFORM/Contents/Resources/Compilers/ni" "-rules" "$INFORM/Contents/Resources/Inform7/Extensions" "-package" build-temp "-extension=ulx" "-log" > runtest.log 2>&1 || (cat runtest.log;false) || exit
cd build-temp/Build
"$INFORM/Contents/Resources/Compilers/inform-6.32-biplatform" "-kE2SDwG" "+include_path=$INFORM/Contents/Resources/Library/Natural,.,../Source" ./auto.inf ./output.ulx > runtest.log 2>&1 || (cat runtest.log;false) || exit
cd ../..
ln -s build-temp/Build/gameinfo.dbg test-debug.glkdata
ln -s build-temp/Build/auto.inf test-I6.glkdata
ln -s build-temp/Build/Debug\ log.txt test-log.glkdata
head -n1 $1 | sed -e 's/^\[//' -e 's|\]$|/quit/y|' -e 's| */ *|/|' -e 's|^/||' | tr '/' $'\n' | ../debuggging/sleepgit build-temp/Build/output.ulx | sed 's/Serial number ....../Serial number XXXXXX/'
if [ -z "$2" ]
then
    rm -r build-temp
    rm runtest.log
fi
rm test-debug.glkdata test-I6.glkdata test-log.glkdata
