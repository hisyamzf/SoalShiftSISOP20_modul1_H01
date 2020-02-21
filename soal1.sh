		'\t'
#!/bin/bash

#1a. 

clear
a=`awk -F "," 'NR>1{var[$13]+=$21} END{for( c in var) printf "%s,%f\n",c , var[c]}' Sample-Superstore.csv | sort -g -t"," -k 2  | awk -F "," 'NR<2 {printf "%s\n", $1 }'`
echo $a
echo ""

#1b.

b=`awk -F "," -v a=$a 'NR>1{if($13~a)var[$11]+=$21} END{for(i in var) printf "%s,%f\n",i, var[i]}' Sample-Superstore.csv | sort -g -t"," -k 2 | awk -F "," 'NR<3 {printf "%s\n", $1 }'`
c1=`echo $b | awk -F " " '{print $1}'`
c2=`echo $b | awk -F " " '{print $2}'`
echo $c1 $c2 
echo ""

#1c.

awk -F "," -v c=$c1 'NR>1{if($11~c)var[$17]+=$21} END{for(i in var) printf "%s,%f\n",i, var[i]}' Sample-Superstore.csv | sort -g -t"," -k 2 | awk -F "," 'NR<11 {printf "%s\n", $1 }'
echo ""
awk -F "," -v d=$c2 'NR>1{if($11~d)var[$17]+=$21} END{for(i in var) printf "%s,%f\n",i, var[i]}' Sample-Superstore.csv | sort -g -t"," -k 2 | awk -F " ," 'NR<11 {printf "%s\n", $1}'

