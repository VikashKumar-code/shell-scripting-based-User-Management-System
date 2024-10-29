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
echo 'Delete a user with name USER_NAME and comments field of COMMENT'
exit 1
fi

#Store 1st Arguement as Username
USER_NAME="${1}"

userdel -r $USER_NAME

#Check if the user is deleted  successfully or not
if [[ $? -ne 0 ]]
then
echo "The Account could not be deleted."
exit 1
fi

echo "User account is deleted Successfully"

