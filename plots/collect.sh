#!/bin/bash
F1=$$.tmp.1
F2=$$.tmp.2

grep -aH PHI "$@" | grep -v LOG \
  | awk '{print $1 " " $7}' \
  | sed 's/.*-\([^-]\+\)-PHI\([0-9]\+\)-W\([0-9]\+\)\(.*\)/\1 \2 \3 \4/' \
  | sed 's/-/ /g' \
  | sed 's/\(.*\):[^ ]\+\(.*\)/\1 \2/' \
  | sed 's/false/0/g' \
  | sed 's/true/1/g' \
  | sed 's/\([^ ]\+\) \+\([^ ]\+\) \+\([^ ]\+\) \+\([^ ]\+\) \+\([^ ]\+\) \+\([^ ]\+\) \+\([^ ]\+\)/\1 \2 \3 \7 \4\5\6/' \
  | tr -s "  " " " \
  | sort -k 1 > $F1



(echo 'obase=10;ibase=2;' && (cat $F1 | grep GEN | awk '{print $5}')) \
  | bc \
  | paste $F1 - \
  | sed 's/\(NAIVE.*\)/\1 NAIVE -2/' \
  | sed 's/\(SHARED.*\)/\1 SHARED -1/' \
  | awk '{print $1 " " $2 " " $3 " " $4 " " $5 " " $6}' \
  | sed 's/\([^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+\) 0\([01][01]\) \([^ ]\+\)/\1 R\2 \3/' \
  | sed 's/\([^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+\) 1\([01][01]\) \([^ ]\+\)/\1 S\2 \3/' \
  | sed 's/\([^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+\) \([SR]\)0\([01]\) \([^ ]\+\)/\1 \2R\3 \4/' \
  | sed 's/\([^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+\) \([SR]\)1\([01]\) \([^ ]\+\)/\1 \2S\3 \4/' \
  | sed 's/\([^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+\) \([SR][SR]\)0 \([^ ]\+\)/\1 \2R \3/' \
  | sed 's/\([^ ]\+ [^ ]\+ [^ ]\+ [^ ]\+\) \([SR][SR]\)1 \([^ ]\+\)/\1 \2S \3/' \
  | sort -n -k6 -k2 -k3 > $F2

cat $F2

rm $F1 $F2

