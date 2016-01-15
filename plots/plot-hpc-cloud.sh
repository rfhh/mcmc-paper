#!/bin/bash

grep iteration ../data/hpc-cloud/friendster-throughput-* \
  | grep -v minibatch \
  | sed 's/.*-K\([0-9]\+\).*:/\1/' \
  | awk '{print "echo " $1 " " $3 " $((16#" $4 "))" }' \
  | bash \
  | awk '{print $1 " " $2/$3}' \
  | sort -n > $$.tmp

grep iteration ../data/hpc-cloud/dblp-throughput-T40-* \
  | grep -v minibatch \
  | sed 's/.*-K\([0-9]\+\).*:/\1/' \
  | awk '{print "echo " $1 " " $3 " $((16#" $4 "))" }' \
  | bash \
  | awk '{print $1 " " $2/$3}' \
  | sort -n > $$.tmp.hpc40

grep iteration ../data/hpc-cloud/dblp-throughput-T16-* \
  | grep -v minibatch \
  | sed 's/.*-K\([0-9]\+\).*:/\1/' \
  | awk '{print "echo " $1 " " $3 " $((16#" $4 "))" }' \
  | bash \
  | awk '{print $1 " " $2/$3}' \
  | sort -n > $$.tmp.hpc16


grep iteration ../data/sweep-over-K-fixed-np/*/* \
  | grep -v minibatch \
  | sed 's/.*-K\([0-9K]\+\).*:/\1/' \
  | sed 's/\([0-9]\+\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | awk '{print $1 " " $3/$4}' \
  | sort -n \
  | head -n 5 > $$.tmp.2

grep iteration ../data/sweep-over-K-fixed-np-dblp/*/* \
  | grep -v minibatch \
  | sed 's/.*-K\([0-9K]\+\).*:/\1/' \
  | sed 's/\([0-9]\+\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | awk '{print $1 " " $3/$4}' \
  | sort -n  > $$.tmp.3

grep iteration ../data/sweep-over-K-fixed-np-dblp-np1/*/* \
  | grep -v minibatch \
  | sed 's/.*-K\([0-9K]\+\).*:/\1/' \
  | sed 's/\([0-9]\+\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | awk '{print $1 " " $3/$4}' \
  | sort -n  > $$.tmp.4

cat <<EOF | gnuplot --persist
set xlabel "Time (hours)"
set ylabel "Perplexity"
#set xrange [0:]
set nokey
set grid ytics

w = 0.6
h = 0.4
k = 0.0
nr = 1
nc = 2
row(x) = ((nr-x-1)*h)+k
col(x) = x*w

set terminal postscript eps enhanced color font ',8'
set size (nc*w),(nr*h+k)
set output 'hpc-cloud.eps'
set multiplot layout nr,nc
set size w,h

set xlabel "Number of Communities (K)"
set ylabel "Time per iteration (milliseconds)"
#set xrange [256:]
set grid ytics
set key below


set origin col(0),row(0)
set size w,h
set title '(a) Performance of HPC Cloud (16 and 40 cores) vs. 1 DAS5 node (16 cores) using com-DBLP'
plot \
     "$$.tmp.hpc40" u 1:(1000*\$2) w lp t 'HPC Cloud 40-cores', \
     "$$.tmp.hpc16" u 1:(1000*\$2) w lp t 'HPC Cloud 16-cores', \
     "$$.tmp.4" u 1:(1000*\$2) w lp t 'Single DAS5 node 16-cores'

set origin col(1),row(0)
set size w,h
set title '(b) Performance of HPC Cloud (40 cores) vs. 64 DAS5 nodes (64*16 cores) using com-Friendster'
plot \
     "$$.tmp" u 1:(1000*\$2) w lp t 'HPC Cloud', \
     "$$.tmp.2" u 1:(1000*\$2) w lp t '64 DAS5 nodes'

EOF

cat $$.tmp*

rm $$.tmp*
