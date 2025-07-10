#!/bin/bash

script_name="/Users/alex/nudge_SystemSettings_helper.sh" # Replace with the actual script name

if [ -x "$script_name" ]; then
	echo "The script '$script_name' is executable."
else
	echo "The script '$script_name' is NOT executable."
fi