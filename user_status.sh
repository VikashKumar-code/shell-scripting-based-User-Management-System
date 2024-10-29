#!/bin/bash

#Script should be execte with either root or sudo access.
if [[ "${UID}" -ne 0 ]]
then
echo "Alert! Please run the script either with sudo or root"
exit
fi

#Script should be taken at least one Arguement else guide them
if [[ "${#}" -lt 1 ]]
then
echo "Usage : ${0} USER_NAME [COMMENT].."
echo 'Mention a user with name USER_NAME and comments field of COMMENT'
exit 1
fi

#store 1st arguement as Username
Username="${1}"

#check the user account status
if id "$Username" &>/dev/null;
then
	account_status=$(sudo passwd -S "$Username" | awk '{print $2}')
	if [[ "$account_status" == "L" ]];
	then
		echo "User $Username is Locked"
	else
		echo "User $Username is Unlocked"
	fi
else
	echo "User $Username doesn't Exist"
	exit 1
fi

#user input

account_status=$(sudo passwd -S "$Username" | awk '{print $2}')
read -p "Do you want to change the status of $Username [y/n]" value
if [[ "$value" == "y" || "$value" == "Y" ]];
then
	
        if [[ "$account_status" == "L" ]];
	then
		
		sudo usermod -U "$Username"
		echo "User account status changed successfully"
		echo "User $Username is Unlocked now"
	
	elif [[ "$account_status" == "P" ]]; 
	then
		sudo usermod -L "$Username"
		echo "User account status changed successfully"
                echo "User $Username is locked now"
	else
		echo "User $Username status is unknown"
	fi
else
	echo "Thank you"
	exit 1
fi
