#!/bin/bash

TFILE=$$.tmp

BASELINE=374.667


echo > $TFILE

X=1
# for i in GeForceGTXTITANX GeForceGTX980 TeslaK40c TeslaK20m Intel-R-Xeon; do
for i in 'TITANX(Pascal)' GeForceGTXTITANX GeForceGTX980 TeslaK40c TeslaK20m ; do
# for i in 'TITANX(Pascal)' ; do
  v=`grep -a TOTAL dblp-K1024/${i}* | sort -nk 7 | head -n 1 | awk '{print $7}'`
  v2=`perl -e "print $BASELINE / $v"`
  device=`echo $i | sed 's+TITANX\(Pascal\)+Titan-X/Pascal+'`
  echo $X $device $v2 >> $TFILE
  X=`expr $X + 1`
done

cat $TFILE

cat <<EOF | gnuplot --persist

set terminal postscript eps enhanced color font ',10' size 3.3,1.6
set output 'gpus.eps'
set colorsequence classic

set boxwidth 0.5
set style fill solid

set ylabel 'Speedup over baseline'

set yrange[0:]

set title 'Performance of different compute devices'
plot '$TFILE' u 1:3:xtic(2) w boxes notitle

EOF

rm $TFILE
