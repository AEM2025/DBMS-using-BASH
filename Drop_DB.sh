#!/bin/bash 

# Test Cases:
# 1 - [Done...] Check if Databases file exist or not.
# 2 - [Done...] Check if DB is already exist before removing it.

read -rp "Enter the name of db you want to remove: " db_name;

# we use this variable as flag to check everything is ok.
error=""

# function for validations
function Validation {
	if [ -d "./DataBases" ]
	then
		error="0"
	else
		error="1"
		echo "Error! DataBases file not exist ❌"
	fi

	if [ -d "./DataBases/$db_name" -a $error = 0 ]
	then
		error="0"
	else
		error="1"
	       	echo "Error! No Database with this name: $db_name ❌"

	fi
}


# Call function validation first 
Validation

if [ $error = 0 ]
then
       	rm -r ./DataBases/$db_name 
	echo "Database: $db_name deleted successfully ✓ ✓"
else

	echo "Can't complete this action ❌❌"
fi
