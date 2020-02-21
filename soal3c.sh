#!/bin/bash

cat wget.log | grep Location: > location.log

mkdir kenangan
mkdir duplicate
awk '{
	i++
	print i ";" $2
}' location.log | awk -F ';' '{
	cnt[$2]++
	if (cnt[$2] > 1) {
		cmd = "mv pdkt_kusuma_" $1 " duplicate/duplicate_" $1
	} else {
		cmd = "mv pdkt_kusuma_" $1 " kenangan/kenangan_" $1
	}
	system(cmd)
}'
ls *.log | awk '{
	cmd = "cp " $0 " " $0 ".bak"
	system(cmd)
}'
