#!/bin/bash
DATA_HOME=/data2/annotate/data/public
cd $DATA_HOME
for file in `find . -name pdfinfo.txt`;
do
    repoid=`echo file | awk 'BEGIN { FS = "/" } ; { print $2 }'`
    repoid=`echo repoid | awk 'BEGIN { FS = "-" } ; { print $1 }'`
    opdate=`echo file | awk 'BEGIN { FS = "/" } ; { print $3 }'`
    filekey=`echo file | awk 'BEGIN { FS = "/" } ; { print $4 }'`
    pages=`sed -n 2p $file`
    sql="update instance_$repoid.veeva_doc_version set pages=$pages where annotate_doc_key='OK $opdate $filekey'"
    echo "going to run $sql"
done
