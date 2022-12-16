#!/usr/bin/env bash

echo "The Post Build Script START"

if [ -z "$AppCenterTokenForTest" ]
then 
    echo "This script only runs within the context of App Center builds"
    exit
fi

echo "Clone UITest Repository"
git clone https://github.com/tdevere/UITest.git

echo "Current Directory and ls"
echo $PWD
ls

echo "Current Directory and ls"
cd /Users/runner/work/1/s/UITest/
echo $PWD
ls

echo "nuget Restore Package"
nuget restore -NonInteractive ./UITest.sln

echo "Build Solution"
xbuild /Users/runner/work/1/s/UITest/UITest.sln /p:Configuration=Release

echo "List environment variables"
printenv

echo "Login to App Center"
appcenter login --token $AppCenterTokenForTest

echo "Start App Center Test Run"

#note: build apk can be found at last line of build step 
#./XamarinUITest/bin/Debug/com.companyname.xamarinuitest.apk -> /Users/runner/work/1/a/build/com.companyname.xamarinuitest.apk

#appcenter test run uitest 
#--app "Examples/Android_Xamarin_UI_Test" 
#--devices "Examples/tdevere-device-set-1-dc1ea1" 
#--app-path C:\TestFiles\com.companyname.appcenterxamrain_test_example.apk 
#--test-series "das-examples" 
#--locale "en_US" 
#--build-dir C:\Repos\AppCenterXamrain_Test_Example\UITestProject\bin\Release 
#--uitest-tools-dir C:\Users\antho\.nuget\packages\xamarin.uitest\3.2.2\tools
echo "--app AppCenterTestProjects/Xamarin_Build_Script_CLI"
echo "--devices Xamarin_Build_Script_CLI/Samsung"
echo "--app-path /Users/runner/work/1/a/build/com.companyname.xamarinuitest.apk"
echo "--test-series Samples"
echo "--locale en_US"
echo "--build-dir /Users/runner/work/1/s/XamarinUITest/bin/Debug/"
echo "--uitest-tools-dir "


#appcenter test run --app-path /Users/runner/work/1/a/build/com.ManualTestOnDevice.yourapp.apk --app AppCenterSupportDocs/ManualTestOnDevice --devices any_top_1_device --test-series launch-tests --locale en_US -p msft/test-run-origin=Build/Launch --debug --quiet --token $AppCenterTokenForTest


#appcenter test generate uitest --platform android --output-path /Users/runner/work/1/a/GeneratedTest

#nuget restore -NonInteractive /Users/runner/work/1/a/GeneratedTest/AppCenter.UITest.Android.sln

#xbuild /Users/runner/work/1/a/GeneratedTest/AppCenter.UITest.Android.sln /p:Configuration=Release

#appcenter test prepare uitest --artifacts-dir /Users/runner/work/1/a/Artifacts --app-path /Users/runner/work/1/a/build/com.ManualTestOnDevice.ReleaseTest1.apk --build-dir /Users/runner/work/1/a/GeneratedTest/AppCenter.UITest.Android/bin/Release --debug --quiet

#Debug Line
#echo "cat /Users/runner/work/1/a/Artifacts/manifest.json"
#cat /Users/runner/work/1/a/Artifacts/manifest.json

#appcenter test run manifest --manifest-path /Users/runner/work/1/a/Artifacts/manifest.json --app-path /Users/runner/work/1/a/build/com.ManualTestOnDevice.yourapp.apk --app AppCenterSupportDocs/ManualTestOnDevice --devices any_top_1_device --test-series launch-tests --locale en_US -p msft/test-run-origin=Build/Launch --debug --quiet --token $AppCenterTokenForTest

echo "The Post Build Script END"