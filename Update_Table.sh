function updateTable {
   read  -rp "enter the database name:" DB
  
  read -rp "Enter Table Name: " tableName
  
  read -rp "Enter Condition Column name: " Col_Name
  
  fid=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$Col_Name'") print i}}}' "DataBases/$DB/$tableName.DATA")
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    updateTable
  
else
    
    read -rp "Enter Condition Value: " val
    res=$(awk 'BEGIN{FS=":"}{if ($'$fid'=="'$val'") print $'$fid'}' "DataBases/$DB/$tableName.DATA" 2>>./.error.log)
    if [[ $res == "" ]]
    then
      echo "Value Not Found"
    updateTable

    else
    #  
     # read -rp "Enter FIELD name to set " setField
      #setFid=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$setField'") print i}}}' "DataBases/$DB/$tableName.DATA")
      #if [[ $setFid == "" ]]
      #then
       # echo " Not Found, try again"
       #updateTable

      #else
        
        
        read -rp "Enter new Value to set: " newValue
        NR=$(awk 'BEGIN{FS=":"}{if ($'$fid' == "'$val'") print NR}' "DataBases/$DB/$tableName.DATA" 2>>./.error.log)
        oldValue=$(awk 'BEGIN{FS=":"}{if(NR=='$NR'){for(i=1;i<=NF;i++){if(i=='$fid') print $i}}}' "DataBases/$DB/$tableName.DATA" 2>>./.error.log)
        echo $oldValue
        sed -i ''$NR's/'$oldValue'/'$newValue'/g' "DataBases/$DB/$tableName.DATA" 2>>./.error.log
        echo "Row Updated Successfully"
        updateTable
      #fi
    fi
  fi
}


#cut -d: -f1 "DataBases/$DB/$tableName.metadata" | xargs |sed -e 's/ /:/g'>"DataBases/$DB/$tableName.DATA"

#echo "hello "
updateTable
