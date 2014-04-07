#!/bin/bash
echo "Выполняется скрипт-стенд"

#analysing settings.txt
#analysing input rastrs
chmod +x fileHandler.pl
rastrs=$(perl fileHandler.pl)
IFS=', ' read -a array <<< "$rastrs"
for ((i=0; i<${#array[*]}; i++));
do	
    if (("$i"<"1"));
    then
    	lay_names=${array[$i]}
    else
	lay_names=$lay_names','${array[$i]}
    fi
done
#analysing last parametrs
chmod +x botFileHandler.pl
lastparams=$(perl botFileHandler.pl)
IFS=',' read -a params <<< "$lastparams"
for ((i=0; i<${#params[*]}; i++));
do	
    	echo ${params[$i]}
done
#zhadni algoritm
#poisk luchei dvoiki sloev
START=$(date +%s%N )/1000000 #time start
count=0
for ((i=0; i<${#array[*]}; i++));
do
	for ((j=i+1; j<${#array[*]}; j++));
	do
		lays=${array[$i]}','${array[$j]}
		match[count]=$(bash analyser.sh $lays ${params[0]} ${params[1]} ${params[2]} ${params[3]})
		paral_lay_names[count]=$lays
		count=$count+1;
	done
done
min=${match[0]}
min_index=0
for ((i=1; i< $count; i++));
do
	if (("${match[i]}" < "$min"))
	then
		min=${match[i]}
		min_index=$i
		echo "Yes!!!!!!!!! "${paral_lay_names[i]}
	fi
done
best_lays=${paral_lay_names[min_index]}
#printing results
#for ((i=0; i< $count; i++));
#do
#	echo ${paral_lay_names[i]}" "${match[i]}
#done
echo $min" "$best_lays

#poisk s 3-sloev
count2=0
fl_better_match=0
min2=0
for ((i=0; i<${#array[*]}; i++));
do
	for ((j=0; j<${#array[*]}; j++));
	do
		lays=$best_lays','${array[$j]}
		match2[count2]=$(bash analyser.sh $lays ${params[0]} ${params[1]} ${params[2]} ${params[3]})
		paral_lay_names2[count2]=$lays
		count2=$count2+1;
	done
	for ((k=0; k<${#match2[*]}; k++));
	do
		if (("${match2[k]}"<"$min"))
		then
			fl_better_match=1
			min2=${match2[k]}
			best_lays=${paral_lay_names2[k]}
		fi
	done
	if ((min2>0))
	then
		min=$min2
	fi
	if (("$fl_better_match"<1))
	then
		echo "Worse result. Step: "$i+3
		i=${#array[*]}
	fi
	fl_better_match=0
done
END=$(date +%s%N )/1000000
DIFF=$(( $END - $START ))
echo $min" "$fl_better_match" "$best_lays
echo "Time of work: "$DIFF" ms"
#printing results
#for ((i=0; i< $count; i++));
#do
	#echo ${paral_lay_names[i]}" "${match[i]}
#done
#delta=$(bash analyser.sh "L5_B50,L5_B30" ${params[0]} ${params[1]} ${params[2]} ${params[3]})
#echo DELTA: $delta
