 #!/usr/bin/bash
export LC_COLLATE=C
shopt -s extglob 

read -p "Enter the db name:" DB
read -p "Enter table name:" tableName
while true
do
if [[ -f "DataBases/$DB/$tableName.DATA" ]];then
     
    
    select choice  in "Select All" "Select Column" "Select by column"
    do
        case $choice in
        "Select All" )
            cat "DataBases/$DB/$tableName.DATA"
            echo -n ""
        ;;
        "Select Column" )
            nf=`awk -F : '{if(NR==1){print  NF'}} "DataBases/$DB/$tableName.DATA"`
            for i in $(seq 1 $nf)
            do
                
                allcolumn=`awk -F : '{if(NR==1){print $i}}' "DataBases/$DB/$tableName.DATA"`
                singlecolumn=`awk -F : -v x=$i '{if(NR==1){print $i}}' "DataBases/$DB/$tableName.DATA"`
                echo "the table columns are : "$allcolumn
                read -p "Enter column name:" column
                colname=`sed -n '1p' "DataBases/$DB/$tableName.DATA" | grep -o $column `
                colnum=`cat "DataBases/$DB/$tableName.DATA" | awk -F : -v b="$column" '{for (i=1;i<=NF;i++) {if($i == b){print i} }}'`
                if [[ $column  ==  $colname ]]; then
                    cut -d ":" -f $colnum "DataBases/$DB/$tableName.DATA"
                    break
                    
                else
                    echo "this column doesn't exist"
                    break
                fi
            done
            
        ;;
        "Select by column" )
             nf=`awk -F : '{if(NR==1){print  NF'}} "DataBases/$DB/$tableName.DATA"`
            for i in $(seq 1 $nf)
            do
                
                allcolumn=`awk -F : '{if(NR==1){print $i}}' "DataBases/$DB/$tableName.DATA"`
                singlecolumn=`awk -F : -v x=$i '{if(NR==1){print $i}}' "DataBases/$DB/$tableName.DATA"`
                echo "the table columns are : "$allcolumn
                read -p "Enter column name:" column
                
                colname=`sed -n '1p' "DataBases/$DB/$tableName.DATA" | grep -o $column `
                colnum=`cat "DataBases/$DB/$tableName.DATA" | awk -F : -v b="$column" '{for (i=1;i<=NF;i++) {if($i == b){print i} }}'`
                if [[ $column  ==  $colname ]]; then
                    read -p "Enter the value you want: " word
                    sed -n "/$word/p" "DataBases/$DB/$tableName.DATA" 
                    break
                    
                else
                    echo "this column doesn't exist"
                    break
                fi
            done
        ;;
        esac
    done
else
    echo "this table doen't exist "
    read -p "Enter table name:" tablename

fi
done
