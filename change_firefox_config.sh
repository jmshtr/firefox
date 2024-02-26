#!/bin/bash

# Define ANSI colour and style escape codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Colour

# Define the preferences and their values
preferences=(
    "extensions.pocket.enabled:false"
    "browser.compactmode.show:true"
    "browser.tabs.tabmanager.enabled:false"
)

# Check if Firefox is running
if pgrep firefox; then
    echo -e "${RED}${BOLD}Firefox is running. Please close it before running this script.${NC}"
    exit 1
fi

# Find the user's Firefox profile directory
PROFILE_DIR=$(find ~/.mozilla/firefox -maxdepth 1 -type d -name "*.default*" | head -n 1)

if [ -z "$PROFILE_DIR" ]; then
    echo -e "${RED}${BOLD}Firefox profile directory not found.${NC}"
    exit 1
fi

# Edit the preferences in the user.js file
for pref in "${preferences[@]}"; do
    IFS=':' read -r pref_name pref_value <<< "$pref"
    echo "user_pref(\"$pref_name\", $pref_value);" >> "$PROFILE_DIR/user.js"
    echo -e "Preference '${GREEN}${BOLD}$pref_name${NC}' set to '${GREEN}${BOLD}$pref_value${NC}' in Firefox's ${BOLD}about:config${NC}."
done
