#!/bin/bash

UNIT_TEST_SCHEME='WeatherTests'
UI_TEST_SCHEME='WeatherUITests'

DESTINATION='platform=iOS Simulator,OS=latest,name=iPhone 16'

echo "Running unit tests..."
xcodebuild test -scheme $UNIT_TEST_SCHEME -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO' -enableCodeCoverage YES

echo "Running UI tests..."
xcodebuild test -scheme $UI_TEST_SCHEME -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO' -enableCodeCoverage YES
