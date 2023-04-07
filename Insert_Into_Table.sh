#!/bin/bash

: '
Steps: 
1 - [Done...] Read metadat file into array.
2 - [Done...] Regex for check numbers and strings
3 - Check PK and must be uniqe number

Test Cases:
[Done..] 1 - Check Db is already exist.
[Done..] 2 - Check Table is exist.

'
# '\n' read line until new line, so we will read file line by line
# -d delimitar. read until this character.
# -r ignore slash as escaping character.
# <<< Here's string. work as input to the command


read -rp "Enter table name " tableName
DB_Name=$1
error=""
dataTypeError="0"
unique="0"
row=""

# function for validations
function Validation {
	
	# 1 - Check Db is already exist
	if [ -d "./DataBases/$DB_Name" ]
	then
		error="0"
	else
		error="1"
	       	echo "Error! No Database with this name: $DB_Name ❌"
	fi

        # 2 - Check if this table exist or not and Both files are exists (data & Metadata)
	if [ -f "./DataBases/$DB_Name/$tableName.DATA" -a -f "./DataBases/$DB_Name/$tableName.metadata" -a $error = 0 ]
	then
		error="0"
	else
		error="1"		
		echo "Error! This table not exist ❌"
	fi
}

function DataTypeCheck {
	
	Col_dt=$1
	Col_value=$2

	# Must strat ^ and must end $ one or more +
	# REGEX to test numbers and strings
	intRegex="^[0-9]+$"
	strRegex="^[a-zA-Z]+$"

	if [ -z "$Col_value" -o "$Col_value" = " " ]
	then
		dataTypeError="1"
		echo "Error! value can't be empty ❌"
	fi


	if [[ $Col_dt = "n" || $Col_dt = "N" ]]
	then
		if ! [[ $Col_value =~ $intRegex ]]
		then
			dataTypeError="1"
			echo "Error! value must be number ❌"
		fi
	fi

	# if column is string, check regex and If there's any error set flag 1
	if [[ $Col_dt = "s" || $Col_dt = "S" ]]
	then
		if ! [[ $Col_value =~ $strRegex ]]
		then
			dataTypeError="1"
			echo "Error! value must be characters from A-Z only ❌"
		fi
	fi
}

function PK {

	#echo " pk function started"
	Col_value=$1
	Col_pk=$2
	# Check unique for primary key.
	#echo "it's primary key"

	arr=( $(cat "./DataBases/$DB_Name/$tableName.DATA" | cut -d ':' -f '1') )
	for i in "${!arr[@]}"
	do     
		if [ $Col_value = "${arr[$i]}" ]
		then 
			unique="1"
			echo "Error!! primary key must be unique ❌"
		fi      
		#echo "line number ----------------- ${arr[$i]}"
	done
}


Validation

# ${!lines[@]} ----> to read index of this item
# Important Note: if we use i in for loop again, it will start from the previous value at the function PK

if [ $error = 0 ]
then
	IFS=$'\n' read -d '' -r -a lines < "./DataBases/$DB_Name/$tableName.metadata"

	for l in "${!lines[@]}"
	do
		# Split line based on : and save each column in a variable 
		IFS=':' read -r -a column <<< "${lines[l]}"
		Col_Name=${column[0]}
		Col_dt=${column[1]}
		Col_pk=${column[2]}

		read -rp "Enter value for column $Col_Name " Col_value
	
		if [[ $Col_pk = "Yes" ]]
		then
			PK $Col_value $Col_pk
		fi

		DataTypeCheck $Col_dt $Col_value

		#echo " ----------------- $dataTypeError"
		#echo " ------------------$unique"
		#echo " -----------------$l"
		
		if [[ $dataTypeError = 0 &&  $unique = 0 ]]
		then

			if [ $l -eq 0 ]
			then
				row=$Col_value
				#echo " ------------------------- $row"
			else
				#echo " else -------------------- $row"
	    			row="$row:$Col_value"
			fi
		fi
	done

	#echo "-----------------$row"
	#echo "--------------------$dataTypeError"
	#echo "-------------------------$unique"

	if [[ $dataTypeError = 0  && $unique = 0 ]]
	then
		echo $row >> "./DataBases/$DB_Name/$tableName.DATA"
	else
		echo "Can't complete this action ❌"
	fi
fi
