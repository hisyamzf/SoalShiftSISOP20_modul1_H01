#!/bin/bash

kecil='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
gede='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
amt=$(stat -c %y $1 | grep -oP '(?<=[^ ] ).*(?=:.*:)')
a=$(echo $1 | grep -oP '.*(?=\.txt)' | tr ${kecil:$amt:26}${gede:$amt:26} ${kecil:0:26}${gede:0:26})
mv $1 $a".txt"

