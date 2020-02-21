#!/bin/bash

kecil='abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
gede='ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'
a=$(echo $1 | grep -oP '.*(?=\.txt)' | tr ${kecil:0:26}${gede:0:26} ${kecil:`date +%-H`:26}${gede:`date +%-H`:26})
mv $1 $a".txt"

