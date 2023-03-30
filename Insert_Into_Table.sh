#!/bin/bash

: '
Steps: 
1 - Read metadat file into array.
2 - Regex for check numbers and strings
3 - Check PK and must be uniqe number

'
tableName="Phones"
DB="Company"


# Need more clarifcation
IFS=$'\n' read -d '' -r -a lines < "DataBases/$DB/$tableName.metadata"

# new string to save data to it
row=""

for i in "${!lines[@]}"
do
	IFS=':' read -r -a column <<< "${lines[i]}"
	Col_Name=${column[0]}
	Col_dt=${column[1]}
	Col_pk=${column[2]}

	echo "$Col_Name"
	echo "$Col_dt"
	echo "$Col_pk"

	read -rp "Enter $Col_Name" Col_value
	# Must strat ^ and must end $ one or more +
	intRegex="^[0-9]+$"
	strRegex="^[a-zA-Z]+$"

	if [[ $Col_dt = "n" || $Col_dt = "N" ]]
	then
		if ! [[ $Col_value =~ $intRegex ]]
		then
			echo "Error: value must be number!!!!"
		fi

	fi
	
	if [[ $Col_dt = "s" || $Col_dt = "S" ]]
	then
		if ! [[ $Col_value =~ $strRegex ]]
		then
			echo "Error: value must be valid characters only!!"
		fi
	fi


	if [ $i -eq 0 ]
	then
		row=$Col_value
		echo $row >> ./DataBases/$DB/$tableName.DATA
	else
		echo $row:$Col_value >> ./DataBases/$DB/$tableName.DATA

	fi
done
