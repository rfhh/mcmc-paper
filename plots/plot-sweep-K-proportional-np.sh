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

set terminal postscript eps enhanced color font ',8' size 3.3,1.6

set ylabel "Time per Iteration (milliseconds)"
set xlabel "Number of Nodes"
set xrange [0:]
set yrange[0:]
set y2range[0:]
set nokey
set grid ytics

set output 'sweep-over-K-proportional-np.eps'
set title "Weak Scaling (over K)"
plot "$$.tmp" u (\$2-1):(1000*\$3/\$4) w lp axis x1y1
#, "" u (\$2-1):((\$1 * 4 * 65e6/1024**3) / ((\$2-1) * 64 * 1024**3)) w lp axis x1y2

EOF

rm $$.tmp
