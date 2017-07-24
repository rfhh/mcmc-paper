#!/bin/bash

cat <<EOF | gnuplot --persist

set terminal postscript eps enhanced color font 'Helvetica,10' size 3.3,1.6
set output 'cpu-vector.eps'
if (GPVAL_VERSION >= 5.0) { set colorsequence classic }

set boxwidth 0.5
set style fill solid

set xlabel 'Vector Width'
set ylabel 'Time (seconds)'

set yrange[0:]

set title 'CPU performance varying vector width'
plot 'cpu-data' u 2:xtic(1) w boxes notitle

EOF
