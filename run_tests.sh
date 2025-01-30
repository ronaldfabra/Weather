#!/bin/bash

SCHEME='WeatherTests'

DESTINATION="platform=iOS Simulator,OS=18.2,name=iPhone 16"

xcodebuild test -scheme $SCHEME -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO' -enableCodeCoverage YES
