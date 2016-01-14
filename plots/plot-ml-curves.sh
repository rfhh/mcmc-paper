#!/bin/bash

cat <<EOF | gnuplot --persist

#set terminal postscript eps enhanced color font ',8' size 3.3,1.6

set xlabel "Time (seconds)"
set ylabel "Perplexity"
#set xrange [0:]
set nokey
set grid ytics

w = 0.6
h = 0.4
k = 0.0
nr = 2
nc = 3
row(x) = ((nr-x-1)*h)+k
col(x) = x*w

set terminal postscript eps enhanced color font ',8'
set size (nc*w),(nr*h+k)
set output 'ppx.eps'
set multiplot layout nr,nc
set size w,h


set origin col(0),row(0)
set size w,h
#set output 'ppx-amazon.eps'
set title "(a) com-Amazon | K75149-m1K-n32-msx1K-np24"
plot '< grep average_count ../data/ml-curves/log-amazon-K75149-m1K-n32-msx1K-epst1e-04-np24/log.0' u 8:(exp(\$14)) w l

set origin col(1),row(0)
set size w,h
#set output 'ppx-lj.eps'
set title "(b) com-LiveJournal | K192K-flt32-m1K-n32-mxs1K-x1M-np65"
plot '< grep average_count ../data/ml-curves/log-com-LJ-K192K-flt32-m1K-n32-mxs1K-x1M-np65/log.0' u 8:(exp(\$14)) w l

set origin col(2),row(0)
set size w,h
#set output 'ppx-dblp.eps'
set title "(c) com-DBLP | K13477-flt32-m1K-n32-msx4K-x10M-np24"
plot '< grep average_count ../data/ml-curves/log-dblp-K13477-flt32-m1K-n32-msx1K-x10M-epst1e-05-np24/log.0' u 8:(exp(\$14)) w l

set origin col(0),row(1)
set size w,h
#set output 'ppx-friendster.eps'
set title "(d) com-Friendster | K12K-flt32-m16K-n32-mxs-16K-np65"
plot '< grep average_count ../data/ml-curves/log-Friendster-K12K-flt32-m16K-n32-mxs-16K-np65/log.0' u 8:(exp(\$14)) w l

set origin col(1),row(1)
set size w,h
#set output 'ppx-youtube.eps'
set title "(e) com-Youtube | K8385-m1K-n32-msx1K-np15"
plot '< grep average_count ../data/ml-curves/log-youtube-K8385-m1K-n32-msx1K-np15/log.0' u 8:(exp(\$14)) w l

set origin col(2),row(1)
set size w,h
#set output 'ppx-orkut.eps'
set title "(f) com-Orkut | K256K-m1K-n32-msx1K-np65"
plot '< grep average_count ../data/ml-curves/log-orkut-flt32-K256K-m1K-n32-x10M-epst1e-05-np65/log.0' u 8:(exp(\$14)) w l
EOF
