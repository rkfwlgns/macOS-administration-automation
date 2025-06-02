#!/bin/bash

# Function to get uptime in seconds
get_uptime_seconds() {
	# macOS: sysctl kern.boottime returns boot time as seconds since epoch
	boot_time=$(sysctl -n kern.boottime | awk -F'[ ,]' '{print $5}')
	now=$(date +%s)
	echo $((now - boot_time))
}

# Loop until uptime is less than or equal to 172800 seconds (48 hours)
until [ "$(get_uptime_seconds)" -le 172800 ]; do
	# Notify user using osascript (native macOS dialog)
	button=$(osascript -e 'display dialog "Please restart your Mac. It has been running for more than 48 hours." buttons {"OK", "Restart Now"} default button 2')
	
	if [ "$button" = "Restart Now" ]; then
		sleep 5
		sudo shutdown -r now
		exit 0
	else
	# Wait for 1 hour before reminding again
	sleep 3600
	exit 1
	fi
done
