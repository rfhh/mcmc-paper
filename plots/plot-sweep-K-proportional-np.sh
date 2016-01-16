#!/bin/bash

grep iteration ../data/sweep-over-K-proportional-np/*/* \
  | grep -v minibatch \
  | grep -v np5 \
  | sed 's/.*-K\([0-9K]\+\).*-np\([0-9]*\).*log.0:/\1 \2/' \
  | awk '{print $1 " " $2 " " $4 " " $5}' \
  | sed 's/\([0-9]\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | sort -n > $$.tmp

ls ../data/sweep-over-K-proportional-np/*/* \
  | grep -wv np5 \
  | sed 's/.*-K\([0-9K]\+\).*-np\([0-9]\+\).*/\2 \1/' \
  | sed 's/\([0-9]\+\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | sort -n \
  | awk '{print $1-1 " " $2}' > $$.tmp.2

cat $$.tmp

cat <<EOF | gnuplot --persist

w = 0.6
h = 0.4
k = 0.0
nr = 2
nc = 1
row(x) = ((nr-x-1)*h)+k
col(x) = x*w

set terminal postscript eps enhanced color font ',8'
set size (nc*w),(nr*h+k)
set output 'sweep-over-K-proportional-np.eps'
set multiplot layout nr,nc
set size w,h

set xlabel "Number of Nodes"
set xrange [0:]
set yrange[0:500]
set nokey
set grid ytics

set origin col(0),row(0)
set size w,h
set title "(a) Weak Scaling (over K)"
set ylabel "Time per Iteration (milliseconds)"
plot "$$.tmp" u (\$2-1):(1000*\$3/\$4) w lp axis x1y1

set origin col(0),row(1)
set size w,h
set style data histogram 
set style histogram cluster gap 1

set style fill solid noborder
set auto x
set ytics
set mytics
set grid ytics mytics

set yrange[0:*]
set title "(b) Number of communities used per cluster size"
set ylabel "#K"
plot "$$.tmp.2" u 2:xtic(1)

EOF

rm $$.tmp*
