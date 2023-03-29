#!/bin/bash
echo "Enter DB name"
# read -r to handle if he enter '\' it will deal with slash as a character like others.
read -r db_name
# check if this db is already exists
if [ -d DataBases/$db_name ]
then
	echo "this db is already exist!!!!!!!!!!"
else
	mkdir DataBases/$db_name
	echo "DB created successfully.........."
fi
