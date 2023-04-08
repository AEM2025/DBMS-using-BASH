#!/bin/bash


read -rp "Enter table name: " tableName

DB_Name=$1
error=""
function validation {
	if [ -f "DataBases/$DB_Name/$tableName.DATA" -a -f "DataBases/$DB_Name/$tableName.metadata" ] 
	then
		error="0"
	else
		error="1"
		echo "Error! Table not exist ❌"
	fi
}



function Delete_All {
	
	echo "" > "DataBases/$DB_Name/$tableName.DATA"
  	echo "data deleted successfully "
}

function Delete_By_Pk {

	exist=""
	read -rp "Please enter your ID: " pk_val
	arr=( $(cat "./DataBases/$DB_Name/$tableName.DATA" | tail -n +2 | cut -d ':' -f '1') )
	for i in "${!arr[@]}"
	do
		if [ $pk_val = "${arr[$i]}" ]
		then
			exist="1"
			sed -i "/$pk_val/d" "DataBases/$DB_Name/$tableName.DATA"
		fi      
	done
	if [ $exist = 0 ]
	then
		echo "Error! No ID with this value ❌"
	fi

}




validation
if [ $error = 0 ] 
then
	options=("Delete all data" "Delete using PK" "Exit")
	echo "Enter choice from 1 to 3" 
	while [[ $REPLY != "Exit" ]]
	do
		select choice in "${options[@]}"
		do
			case $REPLY in
				1) Delete_All
					;;
				2) Delete_By_Pk
					;;
				3) exit 
					;;   
				*) echo "Error! please,choose from the valid options"   
					;;
			esac
		done
	done
else

     echo "Can't complete this action ❌"
fi 
    
