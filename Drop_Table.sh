#!/bin/bash
read -rp "Enter table that you want to remove: " tableName
# Check if this table exist or not and Both files are exists (data & Metadata)

if [ -f ./DataBases/$1/$tableName.DATA -a -f ./DataBases/$1/$tableName.metadata ]
then
	rm ./DataBases/$1/$tableName.DATA
	rm ./DataBases/$1/$tableName.metadata
	echo "$tableName deleted successfully"
else
	echo "No table with this name $tableName"
fi
