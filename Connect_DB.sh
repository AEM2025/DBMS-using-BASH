#!/bin/bash
#!/bin/bash

#SP3="Please enter your choice"

echo "Enter choices from 1 to 9"
options=("Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Back" "Exit")

while [[ "$REPLY" != "Exit" ]]
do
	select answer in "${options[@]}"
	do
		case $REPLY in
			1) echo "Create Table" ;;
			2) echo "List Table" ;;
			3) echo "Drop Table" ;;
			4) echo "Insert into Table" ;;
			5) echo "Select from table" ;;
			6) echo "Delete from table" ;;
			7) echo "Update table" ;;
			8) echo "Back"
				source ./Mainmenu.sh;;
			9) exit;;
			*) echo "Invalid input please try again later" ;;
		esac
	done
done
