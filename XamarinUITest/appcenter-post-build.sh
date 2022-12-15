#!/usr/bin/env bash

echo "The Post Build Script START"

if [ -z "$AppCenterTokenForTest" ]
then 
    echo "This script only runs within the context of App Center builds"
    exit
fi

echo "Clone UITest Repository"
git clone https://github.com/tdevere/UITest.git
echo "Recursive List Current Directory"
ls -R
echo "Change Directory"
cd UITest
ls
echo "nuget Restore Package"
nuget restore -NonInteractive /UITest.sln
echo "Build Solution"
xbuild /UITest.sln /p:Configuration=Release


appcenter login --token $AppCenterTokenForTest

#appcenter test generate uitest --platform android --output-path /Users/runner/work/1/a/GeneratedTest

#nuget restore -NonInteractive /Users/runner/work/1/a/GeneratedTest/AppCenter.UITest.Android.sln

#xbuild /Users/runner/work/1/a/GeneratedTest/AppCenter.UITest.Android.sln /p:Configuration=Release

#appcenter test prepare uitest --artifacts-dir /Users/runner/work/1/a/Artifacts --app-path /Users/runner/work/1/a/build/com.ManualTestOnDevice.ReleaseTest1.apk --build-dir /Users/runner/work/1/a/GeneratedTest/AppCenter.UITest.Android/bin/Release --debug --quiet

#Debug Line
#echo "cat /Users/runner/work/1/a/Artifacts/manifest.json"
#cat /Users/runner/work/1/a/Artifacts/manifest.json

#appcenter test run manifest --manifest-path /Users/runner/work/1/a/Artifacts/manifest.json --app-path /Users/runner/work/1/a/build/com.ManualTestOnDevice.yourapp.apk --app AppCenterSupportDocs/ManualTestOnDevice --devices any_top_1_device --test-series launch-tests --locale en_US -p msft/test-run-origin=Build/Launch --debug --quiet --token $AppCenterTokenForTest

echo "The Post Build Script END"