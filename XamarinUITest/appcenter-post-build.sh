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
echo "--app $app --devices $devices --app-path $apppath --test-series $testseries --locale $locale --build-dir $builddir --uitest-tools-dir $uitesttoolsdir"

appcenter test run uitest --app "$app" --devices "$devices" --app-path "$apppath" --test-series "$testseries" --locale "$locale" --build-dir "$builddir" --uitest-tools-dir "$uitesttoolsdir" --debug

appcenter test run uitest --app "AppCenterTestProjects/Xamarin_Build_Script_CLI" --devices "Xamarin_Build_Script_CLI/Samsung" --app-path "/Users/runner/work/1/a/build/com.companyname.xamarinuitest.apk" --test-series "Samples" --locale "en_US" --build-dir "/Users/runner/work/1/s/XamarinUITest/UITest/UITest/bin/Release/" --uitest-tools-dir "/Users/runner/.nuget/packages/xamarin.uitest/3.2.9/tools/" --debug

echo "The Post Build Script END"