#!/bin/bash 

echo "enter the  name of db you want to remove "

read -p db_name

if [ -d DataBases/$db_name ]
	then rm -r $db_name 

else

	echo "the entered name is wrong  "
fi
