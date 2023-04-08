#!/bin/bash

# Test Cases:
# [Done..] 1 - Check if DataBases file exist.
# [Done..] 2 - Check if DB file is exist.

DB_Name=$1
# We use this variable as flag. 
error=""

function validation {
	
	# 1 - Check if DataBases file exist.
	if [ -d "./DataBases" ]
        then
		# if this folder exist, go to it. pwd DataBases/
		error="0"
		#echo " 1 ------------------ $error"
        else
                error="1"
		#echo "1------------------- $error "
                echo "Error! DataBases file not exist ❌"
        fi

	# 2 - Check if DB file is exist.
	# Note: - We can use $DB_Name instead of ./DataBases/$DB_Name but keep it for safe.
	# 	- We must check if the error variable is still 0. 
	# 	- Otherwise, we will override the value of it and may cause an errors.
	
	if [ -d "./DataBases/$DB_Name"  -a $error = 0 ]
        then
                error="0"
		#echo "2--------------------- $error"
        else
                error="1"
		#echo "2 -------------------------$error"
                echo "Error! No DB with this name: $DB_Name ❌"
        fi
}


# Call function to check everything
validation

if [ -d "./DataBases/$DB_Name" -a $error = 0 ]
then 
	ls ./DataBases/$DB_Name | grep ".DATA"
else 
	echo "Can't complete this action ❌❌"
fi
