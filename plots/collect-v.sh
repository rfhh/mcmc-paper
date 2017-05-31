#!/bin/bash

function Find {
  RET=$(grep -a PHI "${1}"*W${2}* \
    | grep -v LOG \
    | awk '{print $1 " " $7}' \
    | sed 's/\(:[^ ]\+\)//' \
    | sed 's/.*-\([^-]\+\)-PHI\([0-9]\+\)/\1 \2/' \
    | sed 's/-W\([0-9]\+\)-/ \1 /' \
    | sed 's/-W\([0-9]\+\)/ \1 -/' \
    | awk '{print $1" "$2" "$3" "$5" "$4}' \
    | sort -nk 4 \
    | head -n 1 )
  echo $RET
}
# gets a line of the form:
# GEN 64 1 3.13794 false-true-true
# NAIVE 64 1 3.13794 -

# find best config, get the W{1,2,4} for all
function Collect {
  Find "$1" \
    | awk "{if (\$5 == \"-\") {print \""${1}"\"\$1\"-PHI\"\$2\"-W*\"} else {print \""${1}"\"\$1\"-PHI\"\$2\"-W*-\"\$5} }" \
    | xargs echo echo \
    | bash \
    | xargs ./collect.sh 
}

echo "GPU NO-VECTORIZATION VECTOR-WIDTH=2 VECTOR-WIDTH=4"
Collect dblp-K1024/TITANX-Pascal-K1024-M4096-N32-Snode-R0.01-A0.001-C0- | awk "{print \$4}" | xargs echo '"GTX Titan-X\nPascal"'
Collect dblp-K1024/GeForceGTXTITANX-K1024-M4096-N32-Snode-R0.01-A0.001-C0- | awk "{print \$4}" | xargs echo '"GTX Titan-X\nMaxwell"'
Collect dblp-K1024/GeForceGTX980-K1024-M4096-N32-Snode-R0.01-A0.001-C0- | awk "{print \$4 }" | xargs echo GTX980
Collect dblp-K1024/TeslaK40c-K1024-M4096-N32-Snode-R0.01-A0.001-C0- | awk "{print \$4 }" | xargs echo K40c
Collect dblp-K1024/TeslaK20m-K1024-M4096-N32-Snode-R0.01-A0.001-C0- | awk "{print \$4 }" | xargs echo K20m
