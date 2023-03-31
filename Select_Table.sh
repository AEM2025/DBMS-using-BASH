#!/bin/bash

DB_Name="Company"

error=""

#read -rp "Please enter table name:  " Table_Name
Table_Name="Phones"

function Table_exist {
	if [ -f ./DataBases/$DB_Name/$Table_Name.DATA -a -f ./DataBases/$DB_Name/$Table_Name.metadata ]
	then
		echo "Table exist and everything good"
		error="0"
	else
		echo "Table not exist !!!"
		error="1"
	fi
}
function Select_All {
	echo "-------------------$DB_Name"
	echo "-------------------$Table_Name"
	cat ./DataBases/$DB_Name/$Table_Name.DATA
}

#function Select_Row {}
#function Select_Column {}












options=("Select all" "Select row" "Select Column" "Exit")
echo "Enter choice from 1 to 4"

while [[ $REPLY != "Exit" ]]
do
	select choice in "${options[@]}"
	do

		case $REPLY in
	
			1) echo "select everything"
				Table_exist

				if [[ $error = 0 ]]
				then
					Select_All
				fi
				;;
			2) echo "select specific row" ;;
			3) echo "select specific column" ;;
			4) exit;;
			*) echo "please enter valid option";;
		esac
	done
done

