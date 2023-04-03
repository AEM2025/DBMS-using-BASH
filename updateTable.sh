#!/bin/bash


function updateTable_main_menu(){
    options=("Delete Column" "insert into table" "Return To Main Menu");
        while [[ "$option" != "Return To Main Menu" ]] 
    do
    select option in "${options[@]}"
    do
        case $REPLY in 
            1) echo "Delete Column"
		 . ./deleteColumn.sh; break;;
            2) echo "insert into table" 
		. ./Insert_Into_Table.sh; break ;;
            3) echo "Return To Main Menu"
		 ./mainMenu.sh; break ;;
            *) echo "Invalid option ";;
        esac
    done
    done
}



read -p "Enter Table Name: " tableName;

# check if table exists
if [[ -f DataBases/$tableName.DATA ]]
then
    export  tableName=$tableName;
    echo "$tableName is selected.";
    updateTable_main_menu;
else
    echo "Table does not exist.";
    
fi
