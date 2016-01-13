#!/bin/bash

grep iteration ../data/hpc-cloud/* \
  | grep -v minibatch \
  | sed 's/.*-K\([0-9]\+\).*:/\1/' \
  | awk '{print "echo " $1 " " $3 " $((16#" $4 "))"}' \
  | bash \
  | sort -n >> $$.tmp

cat <<EOF | gnuplot --persist

set terminal postscript eps enhanced color font ',8' size 3.3,1.6

set xlabel "Number of Communities (K)"
set ylabel "Time (seconds)"
#set xrange [256:]
set nokey
set grid ytics


set output 'hpc-cloud.eps'
set title "Scaling K"
plot "$$.tmp" u 1:2 w l

EOF

cat $$.tmp

rm $$.tmp
