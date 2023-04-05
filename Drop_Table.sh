#!/bin/bash

# Test Cases:
# [Done..] 1 - Check if DataBases file exist.
# [Done..] 2 - Check if DB file is exist.
# [Done..] 3 - Check if table exist.

DB_Name=$1
read -rp "Enter table that you want to remove: " tableName

# We use this variables as flag. 
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

        # 3 - Check if this table exist or not and Both files are exists (data & Metadata)

	if [ -f ./DataBases/$DB_Name/$tableName.DATA -a -f ./DataBases/$DB_Name/$tableName.metadata -a $error = 0 ]
	then
		error="0"
		#echo "3---------------------- $error" 
	else
		error="1"
		#echo "3------------------------ $error"
	       	echo "Error! This table not exist ❌"
	fi
}

# call function here.
validation

# Check if error is 0
if [ $error = 0 ]
then
	rm ./DataBases/$DB_Name/$tableName.DATA
	rm ./DataBases/$DB_Name/$tableName.metadata
	echo "$tableName deleted successfully ✓ ✓"
else
        echo "Can't complete this action ❌❌"
fi
