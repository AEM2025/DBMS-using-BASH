#!/bin/bash

SP3="Please enter your choice"

echo "Enter the modification you want to do on the table"
options=("drop table" "insert into table" "select form table" "delete form table" "update table" "exit ")


while [[ "$REPLY" != "exit" ]]
do
	select answer in "${options[@]}"
	do
		case $REPLY in
			1) echo "drop table"
			       . ./Drop_Table.sh      
				 ;;
			2) echo "insert into table"
			      . ./ 	
					;;
			3) echo "select form table"
			       . ./
			       ;;
			4) echo "delete form table" 
				. ./
					 ;;
			5) echo "update table"
				. ./  ;;
			6) exit
				;;
			*) echo "Invalid input please try again later"
			       	;;
		esac
	done
done
