#!/bin/bash

# Improvement
# 1 - Edit choice menu.
# 2 - Edit prompt to be clear.

options=("Create Database" "List Databases" "Connect To Databases" "Drop Database" "Exit")
PS3="Enter choices from 1 to 5: "
while [[ "$choice" != "Exit" ]]
do
	echo " "
	select choice in "${options[@]}"
	do
		case $choice in
			"Create Database" ) source ./Create_DB.sh
			      break
			       	;;
			"List Databases" ) source ./List_DB.sh
			      break
				;;
			"Connect To Databases" ) source ./Connect_DB.sh
			       break
				;;
			"Drop Database" ) . ./Drop_DB.sh
				break
				;;
			"Exit" ) exit
				break
				;;
			*) echo "Invalid input please try again later"
			       	;;
		esac
	done
done
