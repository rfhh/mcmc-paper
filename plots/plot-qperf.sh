cat <<EOI | gnuplot --persist

set terminal postscript eps enhanced color font ',10' size 3.3,1.6
set output 'qperf.eps'

set style line 1 lt 1 lw 2 linecolor rgb "red"
set style line 2 lt 2 lw 2 linecolor rgb "blue"
set style line 3 lt 3 lw 2 linecolor rgb "#006400"
set style line 4 lt 4 lw 2 linecolor rgb "magenta"

set logscale x
set xrange [:3000000]
# set yrange [0.25:10]
set key at 2000000,3
set xlabel "payload size (bytes)"
set ylabel "throughput (GB/s)"
plot \
	"../data/qperf/qperf/qperf-write-bw" with lp ls 1 title "qperf RDMA write", \
	"../data/qperf/qperf/qperf-read-bw"  with lp ls 2 title "qperf RDMA read", \
	"../data/qperf/dkv/thrp"             with lp ls 3 title "DKV store read", \
	"../data/qperf/mpi/read-bw-openmpi"  with lp ls 4 title "MPI roundtrip read"
EOI
