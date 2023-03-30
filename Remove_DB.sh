#!/bin/bash 


read -rp "enter the  name of db you want to remove " db_name

# check if Database exist or not
if [ -d ./DataBases/$db_name ]
then
       	rm -r $db_name 
else

	echo "The entered name is wrong"
fi
