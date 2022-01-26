#!/bin/bash

varCount=0
count=1
while [ $count -lt 6 ]
do
    eval "newVar=\${$count}"
    if [ ! -z $newVar ]; then
	varCount=$(( $varCount + 1))
    fi
    count=$(( $count + 1 ))
done
whichFile=$1
name="$2"
desc="$3"
out=$4
oFile=$5
header=$(./makeHeader.sh $name $desc)
template=$(./cTemplateMaker.sh $whichFile)

if [ $varCount = 5 ] && [ $out = "-o" ]; then
echo "Created File: ${oFile}"
    cat> $oFile <<EOF 
$header
$template 

EOF
elif [ $varCount = 3 ]; then
    cat <<EOF
$header
$template
EOF
else
    cat <<EOF
usage: ./cCodeMaker.sh [-c|-cpp] [name] [description] -o [outputfile]
EOF
fi
