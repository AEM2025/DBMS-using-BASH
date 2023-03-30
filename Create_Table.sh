#!/bin/bash


# read -p --> to read and write message in the same line instead of using echo.
# read -r --> to read \ as a character and skip multiline functionality

read -rp "Please enter table name: " Table_Name
read -rp "Enter number of columns: " Col_Num
for (( i=0; i<$Col_Num;i++ ))
do
	# declare empty string to append everything to it

	Col_Info=""
	read -rp "Enter column name: " Col_Name
	Col_Info="$Col_Name"
	read -rp "Enter column datatype: String (s) or Number (n) " Col_dt
	
	# if [[ $Col_dt = "s" || $Col_dt = "S" ]]
	# Check column datatype whatever it's string or integer
	if [ $Col_dt = s -o $Col_dt = S ]
	then
		echo " --------------------String----------------"
		Col_Info="$Col_Info:$Col_dt"

	elif [[ $Col_dt = "n" || $Col_dt = "N" ]]
	then
		echo "---------------------Number----------------"
		Col_Info="$Col_Info:$Col_dt"
	fi
	
	# By default first column will be the primary key
	
	if [ $i -eq 0 ]
	then
		Col_Info="$Col_Info:Yes"
	else
		Col_Info="$Col_Info:No"
	fi

	# Add data to the file
	echo $Col_Info >> ./DataBases/$1/$Table_Name.metadata
	touch ./DataBases/$1/$Table_Name.DATA
	chmod +x ./DataBases/$1/$Table_Name.DATA
done
