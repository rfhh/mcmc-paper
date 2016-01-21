#!/bin/bash

grep iteration ../data/sweep-over-K-fixed-np-single-buffer/*/* \
  | grep -v minibatch \
  | grep -v K10 \
  | sed 's/.*-K\([0-9K]*\).*log.0:/\1/' \
  | awk '{print $1 " " $3 " " $4}' \
  | sed 's/\([0-9]\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | sort -n > $$.tmp

grep iteration ../data/sweep-over-K-fixed-np/*/* \
  | grep -v minibatch \
  | grep -v K10 \
  | sed 's/.*-K\([0-9K]*\).*log.0:/\1/' \
  | awk '{print $1 " " $3 " " $4}' \
  | sed 's/\([0-9]\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | sort -n > $$.tmp2

cat <<EOF | gnuplot --persist

set terminal postscript eps enhanced color font ',8' size 3.3,1.6

set xlabel "Number of Communities (K)"
set ylabel "Time (seconds)"
#set xrange [256:]
set grid ytics


set output 'sweep-over-K-fixed-np.eps'
set title "Scaling K (fixed np=65)"
set key left
plot "$$.tmp" u 1:2 w lp t "Pipelining disabled", "$$.tmp2" u 1:2 w lp t "Pipelining enabled"

EOF

cat $$.tmp $$.tmp2

rm $$.tmp $$.tmp2
