#!/bin/bash

lay_names=$1
groupname=$2
trainmap=$3
output=$4
etalonmap=$5

i.group group=$groupname subgroup=all input=$lay_names --o --q
i.gensig trainingmap=$trainmap group=$groupname subgroup=all signature=all  --o --q
i.maxlik group=$groupname subgroup=all sigfile=all class=$output --o --q
delta=$(bash delta.sh "$output" "$etalonmap")
echo $delta
#clear group
i.group -r group=$groupname input=$lay_names --q
i.group -r group=$groupname subgroup=all input=$lay_names --q

