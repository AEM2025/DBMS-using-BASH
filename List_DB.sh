#!/bin/bash

# Test cases:
# [Done..] 1 - Check if DataBases file exist or not.
# [Done..] 2 - Check if there's no DBs yet.
# [Done..] 3 - Display only directories in the DataBases folder and ignore files

error=""
function validation {
	
	# 1 - Check if DataBases folder not exist.
	if [ -d ./DataBases ]
	then
		error="0"
	else
		error="1"
		echo "Error! DataBases file not exist ❌"
	fi

	# 2 - Check if there's no DBs yet.
	if [ ! -d "./DataBases/" -a $error = 0 ]
	then
		error="1"
		echo "Error! There's no DBs yet ❌"
	else
		error="0"
	fi
}


# call validation function
validation

if [ $error -eq 0 ]
then
	# 3 - display only directories.
	cd ./DataBases
	ls -d */
else
	echo "Can't complete this action ❌❌"

fi
