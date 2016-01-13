#!/bin/bash

cat <<EOF | gnuplot --persist

set terminal postscript eps enhanced color font ',8' size 3.3,1.6

set xlabel "Time (seconds)"
set ylabel "Perplexity"
set xrange [0:]
set nokey
set grid ytics


set output 'ppx-amazon.eps'
set title "com-Amazon | K75149-m1K-n32-msx1K-np24"
plot '< grep average_count ../data/ml-curves/log-amazon-K75149-m1K-n32-msx1K-epst1e-04-np24/log.0' u 8:(exp(\$14)) w l

set output 'ppx-lj.eps'
set title "com-LiveJournal | K192K-flt32-m1K-n32-mxs1K-x1M-np65"
plot '< grep average_count ../data/ml-curves/log-com-LJ-K192K-flt32-m1K-n32-mxs1K-x1M-np65/log.0' u 8:(exp(\$14)) w l

set output 'ppx-dblp.eps'
set title "com-DBLP | K13477-flt32-m1K-n32-msx4K-x10M-np24"
plot '< grep average_count ../data/ml-curves/log-dblp-K13477-flt32-m1K-n32-msx1K-x10M-epst1e-05-np24/log.0' u 8:(exp(\$14)) w l

set output 'ppx-friendster.eps'
set title "com-Friendster | K12K-flt32-m16K-n32-mxs-16K-np65"
plot '< grep average_count ../data/ml-curves/log-Friendster-K12K-flt32-m16K-n32-mxs-16K-np65/log.0' u 8:(exp(\$14)) w l

set output 'ppx-youtube.eps'
set title "com-Youtube | K8385-m1K-n32-msx1K-np15"
plot '< grep average_count ../data/ml-curves/log-youtube-K8385-m1K-n32-msx1K-np15/log.0' u 8:(exp(\$14)) w l
EOF
