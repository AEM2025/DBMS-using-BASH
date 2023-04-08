#!/bin/bash

# Test Cases:
# [Done..] 1 - Check if DataBases folder not exist.
# [Done..] 2 - If DB not exist
# [Done..] 3 - Check if entered value is null or empty.

read -rp "Please enter database that you want to connect: " DB_Name

error=""
function validation {
	
	# 1 - Check if DataBases folder not exist.
	if [ -d "./DataBases" ]
	then
		error="0"
	else
		error="1"
		echo "DataBases file not exist"
	fi

	# 2 - This Condition to test if DB exist or not
	# 3 - Check entered valu if null or empty

	if [ -d "./DataBases/$DB_Name" -a ! -z "$DB_Name" -a "$DB_Name" != " " -a $error = 0 ]
        then
                error="0"
		#echo "2--------------------- $error"
        else
                error="1"
		#echo "2 -------------------------$error"
                echo "Error! No DB with this name: $DB_Name ❌"
        fi
}



options=("Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Back" "Exit")

# Call validation function
validation

if [ $error -eq 0 ]
then
	PS3="DB $DB_Name -> "	
	echo "Enter choices from 1 to 9"
	while [[ "$REPLY" != "Exit" ]]
	do
		select answer in "${options[@]}"
		do
			case $REPLY in
				1) #echo "Create Table" 
					# Pass DB_Name to the file to create tables inside it
					source ./Create_Table.sh $DB_Name
					;;
				2) #echo "List Table"
				 	. ./List_Table.sh $DB_Name      
					;;
				3) #echo "Drop Table"
					# Pass DB_Name to the file to delete tables from it
					source ./Drop_Table.sh $DB_Name
					;;
				4) #echo "Insert into Table"
					source ./Insert_Into_Table.sh $DB_Name
					;;
				5) #echo "Select from table"
					source ./Select_Table.sh $DB_Name
					;;
				6) echo "Delete from table" 
					. ./Delete_Table.sh $DB_Name		
				;;
				7) #echo "Update table" 
					. ./Update_Table.sh $DB_Name
					;;
				8) #echo "Back"
					source ./Mainmenu.sh;;
				9) exit;;
				*) echo "Invalid input please try again later" ;;
			esac
		done
	done
else
	echo "Can't complete this action ❌❌"
fi

