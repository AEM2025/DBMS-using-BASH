#!/bin/bash

# Improvement
# 1 - Edit choice menu.
# 2 - Edit prompt to be clear.

options=("Create Database" "List Databases" "Connect To Databases" "Drop Database" "Exit")

echo "Enter choices from 1 to 5"
while [[ "$REPLY" != "Exit" ]]
do
	select answer in "${options[@]}"
	do
		case $REPLY in
			1) source ./Create_DB.sh
			       ;;
			2) source ./List_DB.sh
			      ;;
			3) source ./Connect_DB.sh
			       ;;
			4) echo "drop db"
			. ./Drop_DB.sh
				;;
			5) exit
				;;
			*) echo "Invalid input please try again later"
			       	;;
		esac
	done
done
