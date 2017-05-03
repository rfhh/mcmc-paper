
all:
	# distr paper
	./plot-hpc-cloud.sh
	./plot-ml-curves.sh
	./plot-sweep-K-fixed-np.sh
	./plot-sweep-K-proportional-np.sh
	./plot-sweep-np-fixed-K.sh
	# GPU paper
	./plot-qperf.sh
	./plot-all-gpu-detail.sh
	./plot-cpu.sh
	./plot-gpus.sh
	./plot-vector-sweep.sh
	./plot-ppx.sh

clean:
	rm *.eps *.pdf
