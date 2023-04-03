#!/bin/bash

# Test Cases:
# 1 - Validate if Databases file exist or not.
# 2 - Validate DB_name not contain special characters or spaces.

# -r to ignore slash as a multi line and consider it as character.
# -p to read and display message in the same line instead of using echo.

read -rp "Enter DB name: " db_name

# We use this variable for check.

error="0"
function Validations{

	# Check DataBases file exist or not
	
	$Dir='/DataBases'
	echo "$Dir"	
	if [ ! -d $Dir ]
	then
		echo "DataBases file not exist"
		mkdir ./DataBases
	else 
		echo "DataBases file exist"
	fi

	strREGEX="^[a-zA-Z_]+$"

	echo "$db_name &  $strREGEX"
	if [[ $db_name =~ $strREGEX ]]
	then
		error="0"
	else
		error="1"
	fi
}




# check if this db is already exists
# call function to check everything
Validations
if [ $error = 0]
then
	if [ -d ./DataBases/$db_name ]
	then
		echo "this db is already exist!!!!!!!!!!"
	else
		mkdir DataBases/$db_name
		echo "DB created successfully.........."
	fi

else
	echo "Database name contain spaces or special characters"
fi
