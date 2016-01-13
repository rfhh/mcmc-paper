#!/bin/bash

grep iteration ../data/sweep-over-np-fixed-K/*/* \
  | grep -v minibatch \
  | sed 's/.*-K\([0-9K]\+\).*-np\([0-9]*\).*log.0:/\1 \2/' \
  | awk '{print $1 " " $2 " " $4 " " $5}' \
  | sed 's/\([0-9]\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | sort -n -k 2 > $$.tmp

BASE=`head -n 1 $$.tmp | awk '{print $3}'`

cat $$.tmp

cat <<EOF | gnuplot --persist

set terminal postscript eps enhanced color font ',8' size 3.3,1.6

set ylabel "Time (Seconds)"
set xlabel "Number of Nodes"
set xrange [0:]
set yrange[0:]
set y2range[0:]
set y2tics
set nokey
set grid ytics

set output 'sweep-over-np-fixed-K.eps'
set title "Strong Scaling"
plot "$$.tmp" u (\$2-1):3 w lp axis x1y1
#  "" u (\$2-1):(${BASE}/\$3) w lp axis x1y2 t "Speedup over 8-nodes"

EOF

rm $$.tmp
