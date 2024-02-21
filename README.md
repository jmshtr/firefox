# Firefox about:config Script

This script is designed to automate the process of setting preferences in Firefox's `about:config`.

## Disclaimer

This script modifies Firefox configuration files. **Use it at your own risk**. Always make sure to back up important data before running any script that modifies system or application settings.

## Prerequisites

- This script requires `Bash` to run.
- Firefox must be installed on the system.
- Ensure that Firefox is not running when executing this script, as it modifies Firefox configuration files.

## Usage

1. Make sure Firefox is closed.
2. Run the script using the command `sh change_firefox_config.sh`.
3. Once executed, the script will update the `user.js` file within the Firefox profile directory.
4. You can verify the changes by opening Firefox and navigating to `about:config`. Search for the preference to ensure that it has been changed.

