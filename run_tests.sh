#!/bin/bash

UNIT_TEST_SCHEME='WeatherTests'
UI_TEST_SCHEME='WeatherUITests'

DESTINATION='platform=iOS Simulator,OS=latest,name=iPhone 16'
OUTPUT_DIR='./test-reports'

# Crear directorio para los reportes de cobertura si no existe
mkdir -p $OUTPUT_DIR

echo "Running unit tests..."
xcodebuild test -scheme $UNIT_TEST_SCHEME -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO' -enableCodeCoverage YES -resultBundlePath  $OUTPUT_DIR/unit_tests.log

echo "Running UI tests..."
xcodebuild test -scheme $UI_TEST_SCHEME -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO' -enableCodeCoverage YES -resultBundlePath $OUTPUT_DIR/ui_tests.log

# Mover los reportes de cobertura a un lugar accesible
cp -r ~/Library/Developer/Xcode/DerivedData/*/Coverage/*.xccovreport $OUTPUT_DIR/

# Opcional: Listar archivos de cobertura para asegurarte de que todo esté bien
echo "Listing coverage files:"
ls -l $OUTPUT_DIR

echo "Tests and coverage reports are ready."
