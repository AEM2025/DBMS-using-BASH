#!/bin/bash

: '
Steps: 
1 - [Done...] Read metadat file into array.
2 - [Done...] Regex for check numbers and strings
3 - Check PK and must be uniqe number
'

read -rp "Enter table name " tableName
DB=$1


# '\n' read line until new line, so we will read file line by line
# -d delimitar. read until this character.
# -r ignore slash as escaping character.
# <<< Here's string. work as input to the command


# new string to save data to it
row=""

# This flag will be 1 if there's any error in values
flag="0"

# ${!lines[@]} ----> to read index of this item
# check if tablename exist or not first

if [ -f ./DataBases/$DB/$tableName.DATA -a -f ./DataBases/$DB/$tableName.metadata ]
then
	IFS=$'\n' read -d '' -r -a lines < "DataBases/$DB/$tableName.metadata"

	for i in "${!lines[@]}"
	do
		# Split line based on : and save each column in a variable 
		IFS=':' read -r -a column <<< "${lines[i]}"
		Col_Name=${column[0]}
		Col_dt=${column[1]}
		Col_pk=${column[2]}

		#echo "$Col_Name"
		#echo "$Col_dt"
		#echo "$Col_pk"

		read -rp "Enter value for column $Col_Name " Col_value
	
		# Must strat ^ and must end $ one or more +
		# REGEX to test numbers and strings

		intRegex="^[0-9]+$"
		strRegex="^[a-zA-Z]+$"

		# if it's number, check regex and display an error message and set flag 1

		if [[ $Col_dt = "n" || $Col_dt = "N" ]]
		then
			if ! [[ $Col_value =~ $intRegex ]]
			then
				flag="1"
				echo "Error: value must be number !!!!"
			fi
		fi
	
		# if column is string, check regex and If there's any error set flag 1

		if [[ $Col_dt = "s" || $Col_dt = "S" ]]
		then
		
			if ! [[ $Col_value =~ $strRegex ]]
			then
				flag="1"
				echo "Error: value must be valid characters only !!"
			fi
		fi

		# check if there's any error with values. if everything is ok. append vlues to table.DATA file.

		if [[ $flag = 0 ]]
		then
			if [ $i -eq 0 ]
			then
				row=$Col_value
			else
                                row="$row:$Col_value"
			fi
                        echo $row >> ./DataBases/$DB/$tableName.DATA
		#else
			#echo "New values has an error, please solve it and try again"
		fi
	done

else
	echo "Table not exist !!!"
fi

