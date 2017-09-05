#!/bin/bash

log_file=$1
size_file=$2
for i in `sed -n '/video/=' $log_file`; do awk -v i=$i '{if(NR==i)print $0}' $size_file ; done | awk -F" " '{requests+=1; received+=$1; sent+=$2}END{print sent" "received" "requests}'
