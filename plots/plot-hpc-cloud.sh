#!/bin/bash

grep iteration ../data/hpc-cloud/* \
  | grep -v minibatch \
  | sed 's/.*-K\([0-9]\+\).*:/\1/' \
  | awk '{print "echo " $1 " " $3 " $((16#" $4 "))" }' \
  | bash \
  | awk '{print $1 " " $2/$3}' \
  | sort -n > $$.tmp


grep iteration ../data/sweep-over-K-fixed-np/*/* \
  | grep -v minibatch \
  | sed 's/.*-K\([0-9K]\+\).*:/\1/' \
  | sed 's/\([0-9]\+\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | awk '{print $1 " " $3/$4}' \
  | sort -n \
  | head -n 5 > $$.tmp.2

cat <<EOF | gnuplot --persist

set terminal postscript eps enhanced color font ',8' size 3.3,1.6

set xlabel "Number of Communities (K)"
set ylabel "Time per iteration (milliseconds)"
#set xrange [256:]
set grid ytics
set key below


set output 'hpc-cloud.eps'
set title "Scale-up vs Scale-out"
plot "$$.tmp" u 1:(1000*\$2) w lp t 'HPC Cloud', "$$.tmp.2" u 1:(1000*\$2) w lp t '64-nodes on DAS5'

EOF

cat $$.tmp*

rm $$.tmp*
