#!/bin/bash

# Test Cases:
# [Done..] 1 - Check if DataBases file exist.
# [Done..] 2 - Check if DB file is exist.
# [Done..] 3 - Check if table exist.
# [Done..] 4 - Check Table name doesn't contain special characters


# read -p --> to read and write message in the same line instead of using echo.
# read -r --> to read \ as a character and skip multiline functionality

read -rp "Please enter table name: " Table_Name
read -rp "Enter number of columns: " Col_Num

# We use this variables as flag.
error=""

function validation {

	# 1 - Check if DataBases file exist.
	if [ -d "./DataBases" ]
        then
		error="0"
        else
                error="1"
                echo "Error! DataBases file not exist ❌"
        fi

	# 2 - Check if DB file is exist.
	# Note:	- We must check if the error variable is still 0.
	# 	- Otherwise, we will override the value of it and may cause an errors.

	if [ -d "./DataBases/$1" -o $1 = " "-a $error = 0 ]
        then
                error="0"
        else
                error="1"
                echo "Error! No DB with this name: $DB_Name ❌"
        fi

        # 3 - Check if this table exist or not and Both files are exists (data & Metadata)

	if [ -f ./DataBases/$1/$Table_Name.DATA -a -f ./DataBases/$1/$Table_Name.metadata -a $error = 0 ]
	then
		error="1"
 		echo "Error! This table not exist ❌"
	else
		error="0"
	fi

	# 4 - Check Table name doesn't contain special characters

	strREGEX="^[a-zA-Z_]+$"
	if [[ $Table_Name =~ $strREGEX  && $error = "0" ]]
	then
		error="0"
	else
                error="1"
 		echo "Error! Table name contain special character ❌"
	fi

}

# call function here.
validation

if [ $error = 0 ]
then
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
			#echo " --------------------String----------------"
			Col_Info="$Col_Info:$Col_dt"

		elif [[ $Col_dt = "n" || $Col_dt = "N" ]]
		then
			#echo "---------------------Number----------------"
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
		cat    "DataBases/$1/$Table_Name.metadata" | cut -d: -f1 | xargs |sed -e 's/ /:/g'>"DataBases/$1/$Table_Name.DATA"
	done
else
	echo "Can't complete this action ❌❌"
fi
