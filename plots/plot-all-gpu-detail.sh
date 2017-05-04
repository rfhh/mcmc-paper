#!/bin/bash

./plot-gpu-sweep.sh titanx-1024-strategies-w1 `ls dblp-K1024/GeForceGTXTITANX-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh titanx-1024-strategies-w2 `ls dblp-K1024/GeForceGTXTITANX-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh titanx-1024-strategies-w4 `ls dblp-K1024/GeForceGTXTITANX-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh gtx980-1024-strategies-w1 `ls dblp-K1024/GeForceGTX980-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh gtx980-1024-strategies-w2 `ls dblp-K1024/GeForceGTX980-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh gtx980-1024-strategies-w4 `ls dblp-K1024/GeForceGTX980-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh k40-1024-strategies-w1 `ls dblp-K1024/TeslaK40c-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh k40-1024-strategies-w2 `ls dblp-K1024/TeslaK40c-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh k40-1024-strategies-w4 `ls dblp-K1024/TeslaK40c-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh k20-1024-strategies-w1 `ls dblp-K1024/TeslaK20m-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh k20-1024-strategies-w2 `ls dblp-K1024/TeslaK20m-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh k20-1024-strategies-w4 `ls dblp-K1024/TeslaK20m-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh titanx-2048-strategies-w1 `ls dblp-K2048/GeForceGTXTITANX-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh titanx-2048-strategies-w2 `ls dblp-K2048/GeForceGTXTITANX-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh titanx-2048-strategies-w4 `ls dblp-K2048/GeForceGTXTITANX-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh gtx980-2048-strategies-w1 `ls dblp-K2048/GeForceGTX980-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh gtx980-2048-strategies-w2 `ls dblp-K2048/GeForceGTX980-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh gtx980-2048-strategies-w4 `ls dblp-K2048/GeForceGTX980-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh k40-2048-strategies-w1 `ls dblp-K2048/TeslaK40c-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh k40-2048-strategies-w2 `ls dblp-K2048/TeslaK40c-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh k40-2048-strategies-w4 `ls dblp-K2048/TeslaK40c-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh k20-2048-strategies-w1 `ls dblp-K2048/TeslaK20m-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh k20-2048-strategies-w2 `ls dblp-K2048/TeslaK20m-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh k20-2048-strategies-w4 `ls dblp-K2048/TeslaK20m-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`