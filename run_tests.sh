#!/bin/bash

SCHEME='WeatherTests'

# Get the available iOS versions and sort them from newest to oldest
IOS_VERSIONS=$(xcrun simctl list runtimes | grep -o 'iOS [0-9]\{1,\}\.[0-9]\{1,\}' | sed 's/iOS //' | sort -V | sort -r)

# Get the latest version (newest)
LATEST_VERSION=$(echo "$IOS_VERSIONS" | head -n 1)

# Get the major version of the latest version (e.g., 18 from 18.2)
LATEST_MAJOR_VERSION=$(echo "$LATEST_VERSION" | cut -d '.' -f 1)

# Get the previous version (second newest)
PREVIOUS_VERSION=$(echo "$IOS_VERSIONS" | sed -n '2p')

# If the latest version is 18.x, choose the version before 18 (e.g., 17.x)
if [[ $LATEST_MAJOR_VERSION == "18" ]]; then
    # Find the version before 18.x
    PREVIOUS_MAJOR_VERSION=$(echo "$IOS_VERSIONS" | grep -o "^[0-9]\{1,\}" | grep -v "^18$" | sort -V | tail -n 1)
    # Construct the version string
    PREVIOUS_VERSION=$(echo "$IOS_VERSIONS" | grep "^$PREVIOUS_MAJOR_VERSION" | head -n 1)
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
#if check_simulators_for_version "$LATEST_VERSION"; then
#    echo "Using the latest iOS version: $LATEST_VERSION"
#    DEVICE_NAME=$(get_first_device_name "$LATEST_VERSION")
#    DESTINATION="platform=iOS Simulator,OS=$LATEST_VERSION,name=$DEVICE_NAME"
#else
    # If there are no devices for the latest version, use the previous version
    echo "No devices available for the latest version. Using the previous iOS version: $PREVIOUS_VERSION"
    DEVICE_NAME=$(get_first_device_name "$PREVIOUS_VERSION")
    DESTINATION="platform=iOS Simulator,OS=$PREVIOUS_VERSION,name=$DEVICE_NAME"
#fi

# Run the test command
xcodebuild test -scheme $SCHEME -destination "$DESTINATION" CODE_SIGNING_ALLOWED='NO' -enableCodeCoverage YES
