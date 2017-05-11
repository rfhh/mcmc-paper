#!/bin/bash

./plot-gpu-sweep.sh --title "(a) Titan-X K=1024 no vectorization" titanx-1024-strategies-w1 `ls dblp-K1024/GeForceGTXTITANX-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh --title "T(a) itan-X K=1024 vector width=2" titanx-1024-strategies-w2 `ls dblp-K1024/GeForceGTXTITANX-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh --title "T(a) itan-X K=1024 vector width=4" titanx-1024-strategies-w4 `ls dblp-K1024/GeForceGTXTITANX-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh --title "GTX980 K=1024 no vectorization" gtx980-1024-strategies-w1 `ls dblp-K1024/GeForceGTX980-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh --title "GTX980 K=1024 vector width=2" gtx980-1024-strategies-w2 `ls dblp-K1024/GeForceGTX980-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh --title "GTX980 K=1024 vector width=4" gtx980-1024-strategies-w4 `ls dblp-K1024/GeForceGTX980-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh --title "K40c K=1024 no vectorization" k40-1024-strategies-w1 `ls dblp-K1024/TeslaK40c-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh --title "K40c K=1024 vector width=2" k40-1024-strategies-w2 `ls dblp-K1024/TeslaK40c-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh --title "K40c K=1024 vector width=4" k40-1024-strategies-w4 `ls dblp-K1024/TeslaK40c-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh --title "K20m K=1024 no vectorization" k20-1024-strategies-w1 `ls dblp-K1024/TeslaK20m-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh --title "K20m K=1024 vector width=2" k20-1024-strategies-w2 `ls dblp-K1024/TeslaK20m-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh --title "K20m K=1024 vector width=4" k20-1024-strategies-w4 `ls dblp-K1024/TeslaK20m-K1024-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh --title "(b) Titan-X K=2048 no vectorization" titanx-2048-strategies-w1 `ls dblp-K2048/GeForceGTXTITANX-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh --title "(b) Titan-X K=2048 vector width=2" titanx-2048-strategies-w2 `ls dblp-K2048/GeForceGTXTITANX-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh --title "(b) Titan-X K=2048 vector width=4" titanx-2048-strategies-w4 `ls dblp-K2048/GeForceGTXTITANX-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh --title "GTX980 K=2048 no vectorization" gtx980-2048-strategies-w1 `ls dblp-K2048/GeForceGTX980-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh --title "GTX980 K=2048 vector width=2" gtx980-2048-strategies-w2 `ls dblp-K2048/GeForceGTX980-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh --title "GTX980 K=2048 vector width=4" gtx980-2048-strategies-w4 `ls dblp-K2048/GeForceGTX980-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh --title "(c) K40c K=2048 no vectorization" k40-2048-strategies-w1 `ls dblp-K2048/TeslaK40c-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh --title "(c) K40c K=2048 vector width=2" k40-2048-strategies-w2 `ls dblp-K2048/TeslaK40c-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh --title "(c) K40c K=2048 vector width=4" k40-2048-strategies-w4 `ls dblp-K2048/TeslaK40c-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`

./plot-gpu-sweep.sh --title "K20m K=2048 no vectorization" k20-2048-strategies-w1 `ls dblp-K2048/TeslaK20m-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W1*`
./plot-gpu-sweep.sh --title "K20m K=2048 vector width=2" k20-2048-strategies-w2 `ls dblp-K2048/TeslaK20m-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W2*`
./plot-gpu-sweep.sh --title "K20m K=2048 vector width=4" k20-2048-strategies-w4 `ls dblp-K2048/TeslaK20m-K2048-M4096-N32-Snode-R0.01-A0.001-C0-*-W4*`
