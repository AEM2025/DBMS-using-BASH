#!/bin/bash

# Test Cases:
# 1 - Check if DataBases file exist.
# 2 - Check if DB file is exist.
# 3 - Check if table exist.

$DB_Name=$1
read -rp "Enter table that you want to remove: " tableName

# We use this variables as flag. 
error=""

function validation {
	
	# 1 - Check if DataBases file exist.
	if [ -d "./DataBases" ]
        then
		# if this folder exist, go to it. pwd DataBases/
		error="0"
		cd ./DataBases
        else
                error="1"
                echo "Error! DataBases file not exist ❌"
        fi

	# 2 - Check if DB file is exist.
	# Note: we can use $DB_Name instead of ./DataBases/$DB_Name but keep it for safe.

	if [ -d "./DataBases/$DB_Name"  -a $error = 0 ]
        then
		# if this folder exist, go to it. pwd DataBases/Db_Name
                error="0"
		cd $DB_Name
        else
                error="1"
                echo "Error! No DB with this name: $DB_Name ❌"
        fi

        # 3 - Check if this table exist or not and Both files are exists (data & Metadata)

	if [ -f ./DataBases/$DB_Name/$tableName.DATA -a -f ./DataBases/$DB_Name/$tableName.metadata -a $error = 0 ]
	then
		error="0"
	else
		error="1"
	       	echo "Error! This table already exist ❌"
	fi
}

# call function here.
validation

# Check if all variables are 0

if [ $error = 0 ]
then
	rm ./DataBases/$DB_Name/$tableName.DATA
	rm ./DataBases/$DB_Name/$tableName.metadata
	echo "$tableName deleted successfully ✓ ✓"
else
        echo "Can't complete this action ❌❌"
fi
