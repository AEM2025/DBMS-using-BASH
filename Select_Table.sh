#!/bin/bash

DB_Name=$1
error=""
DIR="./DataBases/$DB_Name"

# Enter table name
read -rp "Please enter table name:  " Table_Name

# check if table exist or not first
function Table_exist {
	if [ -f $DIR/$Table_Name.DATA -a -f $DIR/$Table_Name.metadata ]
	then
		error="0"
	else
		echo "Table not exist !!!"
		error="1"
	fi
}

# Select all
function Select_All {
	cat $DIR/$Table_Name.DATA
}

# Select specific row
function Select_Row {

Data_Num=$(cat $DIR/$Table_Name.DATA | wc -l)
echo "We have $Data_Num records in this table"
echo ""
read -rp "Enter number of record that you want: " row
if [ $row -lt $Data_Num ]
then
	data=$(cat $DIR/$Table_Name.DATA | sed -n "$row p" )
	echo "$data"
else
	echo "Enter numbers between 1 and $Data_Num"
fi
}


options=("Select all" "Select row" "Exit" "Back")
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
			2) echo "select specific row"
			       Table_exist
			       if [[ $error = 0 ]]
			       then
				       Select_Row
			       fi
				;;
			3) exit ;;
			4) . ./Connect_DB.sh ;;

			*) echo "please enter valid option";;
		esac
	done
done
