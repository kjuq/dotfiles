#!/bin/sh

# @raycast.schemaVersion 1
# @raycast.title Toggle Menubar
# @raycast.mode silent

CURRENT=$(defaults read NSGlobalDomain _HIHideMenuBar)

if test $CURRENT -eq 1; then
echo "Menubar Shown"
/usr/bin/osascript <<EOT
tell application "System Events"
    tell dock preferences to set autohide menu bar to false
end tell
EOT
else
echo "Menubar Hidden"
/usr/bin/osascript <<EOT
tell application "System Events"
    tell dock preferences to set autohide menu bar to true
end tell
EOT
fi


