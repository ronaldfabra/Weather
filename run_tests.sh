#!/bin/bash

SCHEME='WeatherTests'
DESTINATION="platform=iOS Simulator,OS=latest,name=iPhone 16"

RESULT_DIR="./build/test-logs"
RESULT_BUNDLE="$RESULT_DIR/TestResults.xcresult"
mkdir -p $RESULT_DIR

xcodebuild test -scheme $SCHEME -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO' -enableCodeCoverage YES -resultBundlePath $RESULT_BUNDLE

