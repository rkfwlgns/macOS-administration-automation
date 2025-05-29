#!/bin/bash

# Get the currently logged-in user
loggedInUser=$(who | awk '/console/{print $1}')

# Check if the user is already an admin
if dseditgroup -o checkmember -m "$loggedInUser" admin | grep -q "yes"; then
    echo "$loggedInUser is already an admin."
else
    # Promote the user to admin
    sudo dseditgroup -o edit -a "$loggedInUser" -t user admin
    echo "$loggedInUser has been promoted to admin."

    # Schedule a task to revert the user back to standard user after 24 hours
    echo "sudo dseditgroup -o edit -d $loggedInUser -t user admin" | at now + 24 hours
    echo "$loggedInUser will be reverted back to standard user after 24 hours."
fi
