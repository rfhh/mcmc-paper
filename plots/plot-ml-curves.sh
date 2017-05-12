#!/bin/bash

cat <<EOF | gnuplot --persist

set xlabel "Time (hours)"
set ylabel "Perplexity"
#set xrange [0:]
set nokey
set grid ytics

w = 0.32
h = 0.28
k = 0.0
nr = 2
nc = 3
row(x) = ((nr-x-1)*h)+k
col(x) = x*w

set terminal postscript eps enhanced color font ',8.5'
set colorsequence classic
set size (nc*w),(nr*h+k)
set output 'ppx.eps'
set multiplot layout nr,nc
set size w,h

set origin col(0),row(0)
set size w,h

set title "(a) com-Friendster | 12K communities on 64+1 nodes"
set yrange [105:]
set xrange [-0.5:20.5]
plot '< grep average_count ../data/ml-curves/log-Friendster-K12K-flt32-m16K-n32-mxs-16K-np65/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 4

set origin col(1),row(0)
set size w,h

set yrange [420:]
set xrange [-2.0:66.0]
set title "(b) com-LiveJournal | 192K communities on 64+1 nodes"
plot '< grep average_count ../data/ml-curves/log-com-LJ-K192K-flt32-m1K-n32-mxs1K-x1M-epst5e-05-np65/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 4
set yrange [*:]

set origin col(2),row(0)
set size w,h

set xrange [-2.0:66.0]
set title "(c) com-Orkut | 256K communities on 64+1 nodes"
plot '< grep average_count ../data/ml-curves/log-orkut-flt32-K256K-m1K-n32-x10M-epst3e-05-np65/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 4

set origin col(0),row(1)
set size w,h

set xrange [-0.2:8.2]
set title "(d) com-Youtube | 8,385 communities on 12+1 nodes"
plot '< grep average_count ../data/ml-curves/log-youtube-K8385-m1K-n32-msx1K-epst1e-05-np13/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 4

set origin col(1),row(1)
set size w,h

set yrange [110:]
set xrange [-0.2:8.2]
set title "(e) com-DBLP | 13,477 communities on 20+1 nodes"
plot '< grep average_count ../data/ml-curves/log-dblp-K13477-flt32-m1K-n32-msx1K-x10M-epst5e-05-np21/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 4

set origin col(2),row(1)
set size w,h

set yrange [*:]
set xrange [-1.5:51.5]
set title "(f) com-Amazon | 75,149 communities on 20+1 nodes"
plot '< grep average_count ../data/ml-curves/log-amazon-K75149-m1K-n32-msx1K-epst1e-04-np24/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 4
EOF
