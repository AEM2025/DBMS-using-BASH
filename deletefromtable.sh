#!/bin/bash

read -rp "Enter database name: " DB
read -rp "Enter table name: " tableName
#source ./Insert_Into_Table.sh function validation 

if [[ -f "DataBases/$DB/$tableName.DATA" ]] ;then

    select choice in "delete all data from table " "delete column from table"

    do 
    case $choice in
    "delete all data from table ") 
     echo "" > "DataBases/$DB/$tableName.DATA" 
      echo "data deleted successfully "
                            ;;
     "delete column from table")
        sed -i "/$id/d" "DataBases/$DB/$tableName.DATA" ;;    
      *)  echo "error! please,choose from the valid options" ;;
   esac
   done
 
 else

     echo "this table does not exist"
       fi 
    
