#!/bin/bash

NAME=gpu-vector-sweep.eps
shift

TFILE="$$.tmp"

./collect-v.sh > $TFILE

cat <<EOF | gnuplot --persist
set terminal postscript eps enhanced color font ',8' size 3.3,1.6
set colorsequence classic
set output '$NAME'

set style data histogram
set style histogram cluster gap 1

set xlabel 'GPU'
set ylabel 'Time (normalized over non-vectorized version)'
set key below

set style fill solid noborder
set auto x
set ytics
set mytics
set grid ytics mytics

set yrange [0:*]
plot \
  '$TFILE' u (\$2/\$2):xtic(1) title col, \
  '$TFILE' u (\$3/\$2):xtic(1) title col, \
  '$TFILE' u (\$4/\$2):xtic(1) title col

EOF

rm $TFILE

