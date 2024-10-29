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
echo 'Create a user with name USER_NAME and comments field of COMMENT'
exit 1
fi

#Store 1st Arguement as Username
USER_NAME="${1}"

#In case of more than one arguement, store it as Accounts Comment
shift
COMMENT="${@}"

#Create a password
PASSWORD=$(date +%s%N)

#Create a user
useradd -c "${COMMENT}" -m $USER_NAME

#Check if the user is create successfully or not
if [[ $? -ne 0 ]]
then
echo "The Account could not be created."
exit 1
fi

#set the password for user
echo $PASSWORD | passwd --stdin $USER_NAME

#Check the password is set successfully or not
if [[ $? -ne 0 ]]
then
echo 'Password could not be set'
exit 1
fi


#Force the user to change the password after first login
passwd -e $USER_NAME

#Display the user information like Username, Password and the hostname
echo "----------User Information-----------"
echo "Status : Active"
echo
echo "Username : $USER_NAME"
echo
echo "Password : $PASSWORD"
echo
echo "Hostname : $(hostname)"

