cat <<EOI | gnuplot --persist

set terminal postscript eps enhanced color font ',8' size 3.3,1.6
set output 'qperf.eps'

set logscale x
# set xrange [:2000000]
# set yrange [0.25:10]
set key at 1000000,3
set xlabel "payload size (bytes)"
set ylabel "throughput (GB/s)"
plot \
	"../data/qperf/qperf/qperf-write-bw" with lp title "qperf RDMA write", \
	"../data/qperf/qperf/qperf-read-bw" with lp title "qperf RDMA read", \
	"../data/qperf/dkv/thrp" with lp title "DKV store read", \
	"../data/qperf/mpi/thrp" with lp title "MPI read"
EOI
