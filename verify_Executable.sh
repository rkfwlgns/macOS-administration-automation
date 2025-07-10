#!/bin/bash
#checks script to see if it is executable

script_name="<your script>" # Replace with the actual script name

if [ -x "$script_name" ]; then
	echo "The script '$script_name' is executable."
else
	echo "The script '$script_name' is NOT executable."
fi
