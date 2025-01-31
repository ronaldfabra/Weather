#!/bin/bash

SCHEME='WeatherTests'

# Get the available iOS versions and sort them from newest to oldest
IOS_VERSIONS=$(xcrun simctl list runtimes | grep -o 'iOS [0-9]\{1,\}\.[0-9]\{1,\}' | sed 's/iOS //' | sort -V | sort -r)

# Get the latest version (newest)
LATEST_VERSION=$(echo "$IOS_VERSIONS" | head -n 1)

# Get the major version (the first number, e.g., 18 from 18.2)
LATEST_MAJOR_VERSION=$(echo "$LATEST_VERSION" | cut -d '.' -f 1)

# Find the version just before the latest major version (not the same major)
PREVIOUS_MAJOR_VERSION=$(echo "$IOS_VERSIONS" | grep -o "^[0-9]\{1,\}" | grep -v "^$LATEST_MAJOR_VERSION$" | sort -V | tail -n 1)

# Construct the version string to use: If last version is 18.x, pick 17.x
if [[ $LATEST_MAJOR_VERSION == $PREVIOUS_MAJOR_VERSION ]]; then
    # If the latest version is 18.x, we take the previous major version (17.x)
    # This ensures you pick a version like 17.x if the last version is 18.x
    DESTINATION_VERSION="$PREVIOUS_MAJOR_VERSION"
else
    # If the latest version is not the same as the major version of the previous release
    DESTINATION_VERSION="$LATEST_MAJOR_VERSION"
fi

# Function to check if there are available simulators for a given iOS version
function check_simulators_for_version {
    local version=$1
    # List devices for that version
    available_devices=$(xcrun simctl list devices "$version" | grep -E 'Booted|Shutdown' | wc -l)

    # If the number of available devices is greater than 0, we consider it available
    if [[ $available_devices -gt 0 ]]; then
        return 0  # Devices available
    else
        return 1  # No devices available
    fi
}

# Function to get the first available device's name (without UDID and status)
function get_first_device_name {
    local version=$1
    # List devices, filter by Booted or Shutdown, then extract the first device's name
    device_name=$(xcrun simctl list devices "$version" | grep -E 'Booted|Shutdown' | head -n 1 | sed -E 's/([^(]+).*/\1/' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Return the name of the first device
    echo "$device_name"
}

# First, try with the latest iOS version
if check_simulators_for_version "$LATEST_VERSION"; then
    echo "Using the latest iOS version: $LATEST_VERSION"
    DEVICE_NAME=$(get_first_device_name "$LATEST_VERSION")
    DESTINATION="platform=iOS Simulator,OS=$LATEST_VERSION,name=$DEVICE_NAME"
else
    # If there are no devices for the latest version, use the previous major version
    echo "No devices available for the latest version. Using the previous major version: $DESTINATION_VERSION"
    DEVICE_NAME=$(get_first_device_name "$DESTINATION_VERSION")
    DESTINATION="platform=iOS Simulator,OS=$DESTINATION_VERSION,name=$DEVICE_NAME"
fi

# Run the test command
xcodebuild test -scheme $SCHEME -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO' -enableCodeCoverage YES
