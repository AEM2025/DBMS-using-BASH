#!/bin/bash

echo "name pf table you want to delete ? "
read tablename 
if [ -f  "DataBases/$1/$tablename.DATA " -o -f  "DataBases $1/$tablename.metadata" ]; then 

    rm -r DataBases/$1/$tablename.DATA
    rm -r DataBases/$1/$tablename.metadata
    echo "$tablename table  has been deleted "
  else 
    echo "table does not exist "
fi








