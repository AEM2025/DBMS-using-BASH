#!/bin/bash



# Test cases: Check if there's no DBs yet.

cd ./DataBases/
DB=$(ls -d */)

if [[ $DB != 0  ]]
then
for i in $DB
do
	echo "$i"	
done

else
	echo "there's no database yet"
fi
