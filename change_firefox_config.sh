#!/bin/bash

# Define the preferences and their values
preferences=(
    "extensions.pocket.enabled:false"
    "browser.compactmode.show:true"
    "browser.tabs.tabmanager.enabled:false"
)

# Check if Firefox is running
if pgrep firefox; then
    echo "Firefox is running. Please close it before running this script."
    exit 1
fi

# Find the user's Firefox profile directory
PROFILE_DIR=$(find ~/.mozilla/firefox -maxdepth 1 -type d -name "*.default*" | head -n 1)

if [ -z "$PROFILE_DIR" ]; then
    echo "Firefox profile directory not found."
    exit 1
fi

# Edit the preferences in the user.js file
for pref in "${preferences[@]}"; do
    IFS=':' read -r pref_name pref_value <<< "$pref"
    echo "user_pref(\"$pref_name\", $pref_value);" >> "$PROFILE_DIR/user.js"
    echo "Preference '$pref_name' set to '$pref_value' in Firefox's about:config."
done
