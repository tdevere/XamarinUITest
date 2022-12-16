#!/usr/bin/env bash

echo "The Post Build Script START"

if [ -z "$AppCenterTokenForTest" ]
then 
    echo "This script only runs within the context of App Center builds"
    exit
fi

echo "Current Directory and ls"
echo $PWD

echo "Clone UITest Repository"
git clone $GitCloneLink

echo "Current Directory and ls"
echo $PWD
ls

echo "nuget Restore Package"
nuget restore -NonInteractive $UITESTProSlnFile

echo "Build Solution"
msbuild $UITESTProSlnFile /p:Configuration=Release

echo "Login to App Center"
appcenter login --token $AppCenterTokenForTest

echo "Start App Center Test Run"
appcenter test run uitest --app $app --devices $devices --app-path $apppath --test-series $testseries --locale $locale --build-dir $builddir --uitest-tools-dir $uitesttoolsdir -v

echo "The Post Build Script END"