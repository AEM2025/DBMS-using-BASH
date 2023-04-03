#! /bin/bash


read -p "Enter column name: " colName;

# get column names from Metadata/$tableName
colNames=($(awk -F: '{print $1}' DataBases/$1/$tableName.metadata))

colFlag=1   #false

# get column number
for i in "${!colNames[@]}"
do 
    if [[ $colName == "${colNames[$i]}" ]]; then
        colFlag=0   #true
        colNum=$(($i+1));  #column-Number
    fi   
done

# validate colName
if [[ $colFlag == 0 ]]; then
# valid colName

    # delete column from Data/$tableName
    cut -d':' --complement -f$colNum DataBases/$1/$tableName.DATA > DataBases/$1/$tableName.tmp
    mv DataBases/$1/$tableName.tmp DataBases/$1/$tableName.DATA

    # delete line containing column from Metadata/$tableName
    sed -i "$colNum"d Databases/$1/$tableName.metadata
else
    echo "invalid column name";
fi
