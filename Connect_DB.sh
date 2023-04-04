#!/bin/bash

# Test Cases:
# [Done..] 1 - Check if DataBases folder not exist.
# [Done..] 2 - If DB not exist

read -rp "Please enter database that you want to connect: " DB_Name

error=""
function validation {
	
	# 1 - Check if DataBases folder not exist.
	if [ -d ./DataBases ]
	then
		error="0"
	else
		error="1"
		echo "DataBases file not exist"
	fi

	# 2 - This Condition to test if DB exist or not
	Check=`find ./DataBases/$DB_Name -type d`
	if [[ $Check = "" ]]
	then
		error="1"
		echo "There's no DB with this name: $DB_Name"
	else
		error="0"
	fi
}



options=("Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Back" "Exit")

# Call validation function
validation

if [ $error -eq 0 ]
then
	echo "Enter choices from 1 to 9"
	while [[ "$REPLY" != "Exit" ]]
	do
		select answer in "${options[@]}"
		do
			case $REPLY in
				1) echo "Create Table" 
					# Pass DB_Name to the file to create tables inside it
					source ./Create_Table.sh $DB_Name
					;;
				2) echo "List Table" ;;
				3) echo "Drop Table"
					# Pass DB_Name to the file to delete tables from it
					source ./Drop_Table.sh $DB_Name
					;;
				4) echo "Insert into Table"
					source ./Insert_Into_Table.sh $DB_Name
					;;
				5) echo "Select from table"
					source ./Select_Table.sh $DB_Name
					;;
				6) echo "Delete from table" ;;
				7) echo "Update table" ;;
				8) echo "Back"
					source ./Mainmenu.sh;;
				9) exit;;
				*) echo "Invalid input please try again later" ;;
			esac
		done
	done
else
	echo "Can't complete this action ❌❌"
fi

