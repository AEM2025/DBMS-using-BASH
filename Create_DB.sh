#!/bin/bash

# Test Cases:
# [Done..] 1 - Validate if Databases file exist or not.
# [Done..] 2 - Validate DB_name not contain special characters or spaces.
# [Done..] 3 - Validate if DB is already exist


# -r to ignore slash as a multi line and consider it as character.
# -p to read and display message in the same line instead of using echo.

read -rp "Enter DB name: " db_name

# We use this variable for check.

error="0"

function Validations {

	# Check DataBases file exist or not
	if [ ! -d "./DataBases" ]
	then
		echo "Warning! DataBases file not exist"
		mkdir ./DataBases
	else 
		echo "DataBases file exist ✓✓"
	fi

	strREGEX="^[a-zA-Z_]+$"
	if [[ $db_name =~ $strREGEX ]]
	then
		error="0"
	else
		error="1"
	fi
}

# call function to check everything
Validations

if [ $error = 0 ]
then
	# check if this db is already exists
	if [ -d ./DataBases/$db_name ]
	then
		echo "Error!! This Database is already exists ❌"
	else
		mkdir DataBases/$db_name
		echo "DB created successfully ✓✓✓"
	fi

else
	echo "Error! Database name contain special characters ❌"
fi
