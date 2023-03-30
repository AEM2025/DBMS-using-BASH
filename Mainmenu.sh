#!/bin/bash

SP3="Please enter your choice"

echo "Enter choices from 1 to 5"
options=("Create Database" "List Databases" "Connect To Databases" "Drop Database" "exit")

while [[ "$REPLY" != "exit" ]]
do
	select answer in "${options[@]}"
	do
		case $REPLY in
			1) echo "Create DB"
			       . ./Create_DB.sh
			       ;;
			2) echo "List DBs"
			      . ./List_DB.sh 	;;
			3) echo "Connect to DBs"
			       . ./Connect_DB.sh
			       ;;
			4) echo "Drop DBs" 
				. ./Remove_DB.sh ;;
			5) exit
				;;
			*) echo "Invalid input please try again later"
			       	;;
		esac
	done
done
