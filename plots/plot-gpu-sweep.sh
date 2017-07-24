#!/bin/bash

# splot '< ./collect.sh build-cu/log-phi-sweep-phi-*' u 1:3:4 w p

PLOT_TITLE="Put your title here"
while true ; do
	case "$1" in
		--title)
			shift
			PLOT_TITLE="$1"
			shift
			;;
		--*)
			echo "Unknown flag: $1"
			exit 37
			;;
		*)
			break
			;;
	esac
done

# echo "Remaining args $@"

NAME=$1
shift

ARGS="$@"

TFILE="$$.tmp"

./collect.sh $ARGS > $TFILE

MIN=`cat $TFILE \
  | awk 'NR == 1 {min = $4}
         NR > 1 && $4 < min {min=$4}
         END {print min}'`
MIN=`perl -e "print $MIN - 1"`
MAX=`perl -e "print $MIN * 2 + 1"`
MID=128

#cat $TFILE

cat <<EOF | gnuplot --persist
w = 0.3
h = 0.32
nr = 2
nc = 1
row(x) = ((nr-x-1)*h)
col(x) = x*w

set terminal postscript eps enhanced color font ',8'
if (GPVAL_VERSION >= 5.0) { set colorsequence classic }
set size (nc*w),(nr*h)
set output '$NAME.eps'
set multiplot layout nr,nc

#set logscale x 2
#set logscale y
set ytics
set mytics
set xtics
set grid ytics xtics

set xlabel "Block Size"
set ylabel "Time (seconds)"

set xrange [0:]
set yrange [0:]
#set key top left
#set key below
unset key

set origin col(0),row(0)
set size w,h
set title '$PLOT_TITLE'
plot \
  '< cat $TFILE | grep NAIVE' u 2:4 w lp title 'NAIVE', \
  '< cat $TFILE | grep SHARED' u 2:4 w lp title 'SHARED', \
  '< cat $TFILE | grep SSS' u 2:4 w lp title 'GEN-SSS', \
  '< cat $TFILE | grep SSR' u 2:4 w lp title 'GEN-SSR', \
  '< cat $TFILE | grep SRS' u 2:4 w lp title 'GEN-SRS', \
  '< cat $TFILE | grep SRR' u 2:4 w lp title 'GEN-SRR', \
  '< cat $TFILE | grep RSS' u 2:4 w lp title 'GEN-RSS', \
  '< cat $TFILE | grep RSR' u 2:4 w lp title 'GEN-RSR', \
  '< cat $TFILE | grep RRS' u 2:4 w lp title 'GEN-RRS', \
  '< cat $TFILE | grep RRR' u 2:4 w lp title 'GEN-RRR'

set origin col(0),row(1)
set size w,h
set title 'As above, zoom-in around optimal settings'
set xrange [32:$MID]
set autoscale y
plot \
  "< cat $TFILE | grep NAIVE  | awk '{if (\$2 <= $MID) print \$0 }'" u 2:4 w lp title 'NAIVE', \
  "< cat $TFILE | grep SHARED | awk '{if (\$2 <= $MID) print \$0 }'" u 2:4 w lp title 'SHARED', \
  "< cat $TFILE | grep SSS    | awk '{if (\$2 <= $MID) print \$0 }'" u 2:4 w lp title 'GEN-SSS', \
  "< cat $TFILE | grep SSR    | awk '{if (\$2 <= $MID) print \$0 }'" u 2:4 w lp title 'GEN-SSR', \
  "< cat $TFILE | grep SRS    | awk '{if (\$2 <= $MID) print \$0 }'" u 2:4 w lp title 'GEN-SRS', \
  "< cat $TFILE | grep SRR    | awk '{if (\$2 <= $MID) print \$0 }'" u 2:4 w lp title 'GEN-SRR', \
  "< cat $TFILE | grep RSS    | awk '{if (\$2 <= $MID) print \$0 }'" u 2:4 w lp title 'GEN-RSS', \
  "< cat $TFILE | grep RSR    | awk '{if (\$2 <= $MID) print \$0 }'" u 2:4 w lp title 'GEN-RSR', \
  "< cat $TFILE | grep RRS    | awk '{if (\$2 <= $MID) print \$0 }'" u 2:4 w lp title 'GEN-RRS', \
  "< cat $TFILE | grep RRR    | awk '{if (\$2 <= $MID) print \$0 }'" u 2:4 w lp title 'GEN-RRR'

#set origin col(2),row(0)
#set size w,h
#set xrange [30:130]
#set yrange [$MIN:$MAX]
#set title '(c) Focused on optimal settings'
#plot \
#  '< cat $TFILE | grep NAIVE' u 2:4 w lp title 'NAIVE', \
#  '< cat $TFILE | grep SHARED' u 2:4 w lp title 'SHARED', \
#  '< cat $TFILE | grep SSS' u 2:4 w lp title 'GEN-SSS', \
#  '< cat $TFILE | grep SSR' u 2:4 w lp title 'GEN-SSR', \
#  '< cat $TFILE | grep SRS' u 2:4 w lp title 'GEN-SRS', \
#  '< cat $TFILE | grep SRR' u 2:4 w lp title 'GEN-SRR', \
#  '< cat $TFILE | grep RSS' u 2:4 w lp title 'GEN-RSS', \
#  '< cat $TFILE | grep RSR' u 2:4 w lp title 'GEN-RSR', \
#  '< cat $TFILE | grep RRS' u 2:4 w lp title 'GEN-RRS', \
#  '< cat $TFILE | grep RRR' u 2:4 w lp title 'GEN-RRR'

unset multiplot
set output 'gpu-sweep-legends.eps'

unset xtics
unset ytics
unset y2tics
unset logscale x
unset logscale y2
unset xlabel
unset ylabel
unset y2label
unset title
unset border

w = 0.8
set origin 0,0
k = 0.05
set size (nc*w),k
set key center horizontal
set xrange[0:1]
set yrange[0:3]
set y2range[0:1]
plot  NaN w lp title 'NAIVE', \
      NaN w lp title 'SHARED', \
      NaN w lp title 'GEN-SSS', \
      NaN w lp title 'GEN-SSR', \
      NaN w lp title 'GEN-SRS', \
      NaN w lp title 'GEN-SRR', \
      NaN w lp title 'GEN-RSS', \
      NaN w lp title 'GEN-RSR', \
      NaN w lp title 'GEN-RRS', \
      NaN w lp title 'GEN-RRR'

set xlabel "Strategy"
set ylabel "Block Size"
set zlabel "Time (seconds)"

#set yrange[32:256]

#set dgrid3d
#splot '$TFILE' u 6:2:4:xtic(5) w lp

EOF

rm $TFILE

