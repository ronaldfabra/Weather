#!/bin/bash

UNIT_TEST_SCHEME='WeatherTests'
UI_TEST_SCHEME='WeatherUITests'
DESTINATION='platform=iOS Simulator,OS=latest,name=iPhone 16'
COVERAGE_DIR="./coverage"
mkdir -p $COVERAGE_DIR

echo "Running unit tests..."
xcodebuild test -scheme $UNIT_TEST_SCHEME -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO' -enableCodeCoverage YES -resultBundlePath $COVERAGE_DIR/unit_test_results

# Generar reporte de cobertura LCOV para unit tests
xcrun xccov view --report --json $COVERAGE_DIR/unit_test_results/Logs/Test/*.xccovreport | jq . | lcov -o $COVERAGE_DIR/unit_test_coverage.lcov

echo "Running UI tests..."
xcodebuild test -scheme $UI_TEST_SCHEME -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO' -enableCodeCoverage YES -resultBundlePath $COVERAGE_DIR/ui_test_results

# Generar reporte de cobertura LCOV para UI tests
xcrun xccov view --report --json $COVERAGE_DIR/ui_test_results/Logs/Test/*.xccovreport | jq . | lcov -o $COVERAGE_DIR/ui_test_coverage.lcov
