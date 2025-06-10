#!/bin/bash

# Set the Desktop path (macOS/Linux)
DESKTOP="$HOME/Desktop"
TARGET="$DESKTOP/Screenshots"

# Create the Screenshots folder if it doesn't exist
mkdir -p "$TARGET"

# Move all files starting with "Screenshot" from Desktop to Screenshots
mv "$DESKTOP"/Screenshot* "$TARGET" 2>/dev/null

echo "All 'Screenshot*' files have been moved to '$TARGET'."

# After the conclusion of this script, you will need to create a .plist with a LaunchAgent configured to continually run the script
# Once the .plist file exists in the ~/Library/LaunchAgents/ folder, run the command:
# launchctl load ~/Users/$HOME/Library/LaunchAgents/<filename.plist>/
