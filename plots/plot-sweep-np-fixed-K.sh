#!/bin/bash

grep iteration ../data/sweep-over-np-fixed-K/*/* \
  | grep -v minibatch \
  | sed 's/.*-K\([0-9K]\+\).*-np\([0-9]*\).*log.0:/\1 \2/' \
  | awk '{print $1 " " $2 " " $4 " " $5}' \
  | sed 's/\([0-9]\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | sort -n -k 2 > $$.tmp

grep "deploy minibatch" ../data/sweep-over-np-fixed-K/*/* \
  | sed 's/.*-K\([0-9K]\+\).*-np\([0-9]*\).*log.0:/\1 \2/' \
  | awk '{print $1 " " $2 " " $5}' \
  | sed 's/\([0-9]\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | sort -n -k 2 > $$.tmp.2

grep "update_phi_pi" ../data/sweep-over-np-fixed-K/*/* \
  | sed 's/.*-K\([0-9K]\+\).*-np\([0-9]*\).*log.0:/\1 \2/' \
  | awk '{print $1 " " $2 " " $4}' \
  | sed 's/\([0-9]\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | sort -n -k 2 > $$.tmp.3

grep "update_beta_theta" ../data/sweep-over-np-fixed-K/*/* \
  | sed 's/.*-K\([0-9K]\+\).*-np\([0-9]*\).*log.0:/\1 \2/' \
  | awk '{print $1 " " $2 " " $4}' \
  | sed 's/\([0-9]\)K/$[\1*1024]/' \
  | sed 's/\(.*\)/echo \1/' \
  | bash \
  | sort -n -k 2 > $$.tmp.4

BASE=`head -n 1 $$.tmp | awk '{print $3}'`
BASE2=`head -n 1 $$.tmp.2 | awk '{print $3}'`
BASE3=`head -n 1 $$.tmp.3 | awk '{print $3}'`
BASE4=`head -n 1 $$.tmp.4 | awk '{print $3}'`

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
set output 'sweep-over-np-fixed-K.eps'
set multiplot layout nr,nc
set size w,h

set xlabel "Number of Nodes"
set xrange [0:]
set yrange[0:]
set key below
set grid ytics

set origin col(0),row(0)
set size w,h
set ylabel "Time (Seconds)"
set title "(a) Execution time"
plot \
     "$$.tmp"   u (\$2-1):3 w lp axis x1y1 t 'total', \
     "$$.tmp.2" u (\$2-1):3 w lp axis x1y1 t 'deploy minibatch', \
     "$$.tmp.3" u (\$2-1):3 w lp axis x1y1 t 'update\_phi\_pi', \
     "$$.tmp.4" u (\$2-1):3 w lp axis x1y1 t 'update\_beta\_theta'

set origin col(0),row(1)
set size w,h
set ylabel "Speedup"
set title "(b) Speedup over 8-nodes"
plot \
     "$$.tmp" u (\$2-1):(${BASE}/\$3) w lp axis x1y1 t "total", \
     "$$.tmp.2" u (\$2-1):(${BASE2}/\$3) w lp axis x1y1 t 'deploy minibatch', \
     "$$.tmp.3" u (\$2-1):(${BASE3}/\$3) w lp axis x1y1 t 'update\_phi\_pi', \
     "$$.tmp.4" u (\$2-1):(${BASE4}/\$3) w lp axis x1y1 t 'update\_beta\_theta'

EOF

rm $$.tmp*
