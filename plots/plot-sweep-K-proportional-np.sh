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

cat $$.tmp

cat <<EOF | gnuplot --persist

w = 0.6
h = 0.4

set terminal postscript eps enhanced color font ',10'
set output 'sweep-over-K-proportional-np.eps'
set size w,h

set xlabel "Number of Nodes"
set xrange [0:]
set yrange[0:500]
set nokey
set grid ytics

set title "Weak Scaling (over K)"
set ylabel "Time per Iteration (milliseconds)"
plot "$$.tmp" u (\$2-1):(1000*\$3/\$4) w lp axis x1y1 lw 2

EOF

rm $$.tmp*
