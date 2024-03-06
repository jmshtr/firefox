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
    "browser.uidensity:1"
    "dom.security.https_only_mode:true"
    "dom.security.https_only_mode_ever_enabled:true"
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

# Check if user has write permissions in Firefox profile directory
if [ ! -w "$PROFILE_DIR/user.js" ]; then
    echo -e "${RED}${BOLD}Error: You do not have write permissions in the Firefox profile directory.${NC}"
    exit 1
fi

# Backup existing user.js file
BACKUP_DIR="$PROFILE_DIR/user.js.bak"
if cp "$PROFILE_DIR/user.js" "$BACKUP_DIR"; then
    echo -e "${GREEN}${BOLD}Backup of user.js created: $BACKUP_DIR${NC}"
else
    echo -e "${RED}${BOLD}Failed to create backup of user.js.${NC}"
    exit 1
fi

# Edit the preferences in the user.js file
for pref in "${preferences[@]}"; do
    IFS=':' read -r pref_name pref_value <<< "$pref"
    echo "user_pref(\"$pref_name\", $pref_value);" >> "$PROFILE_DIR/user.js"
    if [ $? -eq 0 ]; then
        echo -e "Preference '${GREEN}${BOLD}$pref_name${NC}' set to '${GREEN}${BOLD}$pref_value${NC}' in Firefox's ${BOLD}about:config${NC}."
    else
        echo -e "${RED}${BOLD}Failed to set preference '${pref_name}' in user.js.${NC}"
    fi
done
