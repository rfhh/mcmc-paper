#!/bin/bash

cat <<EOF | gnuplot --persist

set xlabel "Time (hours)"
set ylabel "Perplexity"
#set xrange [0:]
set nokey
set grid ytics

w = 0.6
h = 0.4
k = 0.0
nr = 3
nc = 2
row(x) = ((nr-x-1)*h)+k
col(x) = x*w

set terminal postscript eps enhanced color font ',10'
set size (nc*w),(nr*h+k)
set output 'ppx.eps'
set multiplot layout nr,nc
set size w,h

set origin col(0),row(0)
set size w,h

set title "(a) com-Friendster | 12K communities on 64 nodes"
set yrange [105:]
plot '< grep average_count ../data/ml-curves/log-Friendster-K12K-flt32-m16K-n32-mxs-16K-np65/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 5

set origin col(1),row(0)
set size w,h

set yrange [420:]
set title "(b) com-LiveJournal | 192K communities on 64 nodes"
plot '< grep average_count ../data/ml-curves/log-com-LJ-K192K-flt32-m1K-n32-mxs1K-x1M-np65/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 5

set origin col(0),row(1)
set size w,h

set yrange [*:]
set title "(c) com-Orkut | 256K communities on 64 nodes"
plot '< grep average_count ../data/ml-curves/log-orkut-flt32-K256K-m1K-n32-x10M-epst1e-05-np65/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 5

set origin col(1),row(1)
set size w,h

set title "(d) com-Youtube | 8,385 communities on 14 nodes"
plot '< grep average_count ../data/ml-curves/log-youtube-K8385-m1K-n32-msx1K-np15/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 5

set origin col(0),row(2)
set size w,h

set yrange [110:]
set title "(e) com-DBLP | 13,477 communities on 24 nodes"
plot '< grep average_count ../data/ml-curves/log-dblp-K13477-flt32-m1K-n32-msx1K-x10M-epst1e-05-np24/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 5

set origin col(1),row(2)
set size w,h

set yrange [*:]
set title "(f) com-Amazon | 75,149 communities on 24 nodes"
plot '< grep average_count ../data/ml-curves/log-amazon-K75149-m1K-n32-msx1K-epst1e-04-np24/log.0' u (\$8 / 3600):(exp(\$14)) w l lw 5
EOF
