#!/bin/bash

cat << EOF | gnuplot --persist
w = 0.4
h = 0.3
k = 0.0
nr = 2
nc = 1
row(x) = ((nr-x-1)*h)+k
col(x) = x*w

set terminal postscript eps enhanced color font ',8'
set size (nc*w),(nr*h+k)
set output 'ppx-gpu-cpu.eps'
set multiplot layout nr,nc

set origin col(0),row(0)
set size w,h

set xlabel 'Time (hours)'
set ylabel 'Perplexity'

set xrange [-0.15:6.15]
set yrange [62:95]
set title '(a) Com-DBLP K=4K m=4K n=32'
plot "< perl ./get_time.perl ppx-DBLP-K4K-m4K-n32 " using (\$1/3600):3 notitle with lines lw 5

set origin col(0),row(1)
set size w,h

set xrange [-0.3:18.3]
set yrange [53:83]
set title '(b) Com-LiveJournal K=3K m=4K n=32'
plot "< perl ./get_time.perl ppx-LJ-K3K-m4K-n32 " using (\$1/3600):3 notitle with lines lw 5
EOF
