#!/bin/bash

read -p "enter the table name " tablename

if [ -f ./DataBases/$tablename.DATA -o ./DataBases/$tablename.metadata ]

#note that the path is not complete till now 

then ls ./DataBases/ 
else echo "this table does not exist"

fi
