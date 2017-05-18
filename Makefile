LATEX_TOOL  := pdflatex
BIBTEX_TOOL := bibtex
DVIPDF_TOOL := dvipdfm
VIEW_TOOL   := evince
PAPER_BASE  := tpds-paper-ieee
TARGETS     :=
TARGETS     += $(PAPER_BASE).pdf

PAPER_PART :=
PAPER_PART += $(TARGETS:%.pdf=%.tex)
# PAPER_PART += paper.bib
# PAPER_PART += abstract.tex

PAPER_PART += 01-intro.tex
PAPER_PART += 02-background.tex
PAPER_PART += 03-related.tex
PAPER_PART += 04-experimental-setup.tex

# GPU part
# PAPER_PART += gpu-00-abstract.tex
# PAPER_PART += gpu-01-intro.tex
PAPER_PART += gpu-04-02-sequential.tex
PAPER_PART += gpu-04-03-accelerator.tex
PAPER_PART += gpu-04-design.tex
PAPER_PART += gpu-05-02-sequential.tex
PAPER_PART += gpu-05-03-accelerator.tex
PAPER_PART += gpu-05-04-distributed.tex
PAPER_PART += gpu-05-05-perplexity.tex
PAPER_PART += gpu-05-evaluation.tex

# Distr part
# PAPER_PART += distr-01-intro.tex
PAPER_PART += distr-03-design.tex
PAPER_PART += distr-04-evaluation.tex
PAPER_PART += distr-05-conclusion.tex
PAPER_PART += distr-06-acks.tex

PAPER_PART += 06-conclusion.tex

# PAPER_PART += bucket.tex
# add .tex files

.PHONY: clean view all plots

all: $(TARGETS)

# $(TARGETS): plot_dir

plot_dir:
	make -C plots

# $(TARGETS): $(TARGETS:%.pdf=%.tex)
$(TARGETS): $(PAPER_PART)
$(TARGETS): IEEEtran/IEEEtran.cls
$(TARGETS): IEEEtranBST/IEEEtran.bst
$(TARGETS): tpds-paper.bib

plots:
	$(MAKE) $(MFLAGS) -C plots

export TEXINPUTS=.:./IEEEtran/:
export BIBINPUTS=.:./IEEEtranBST/
export BSTINPUTS=.:./IEEEtranBST/

%.pdf: %.tex
	${LATEX_TOOL} ${PAPER_BASE}
	@echo BIBINPUTS $(BIBINPUTS)
	${BIBTEX_TOOL} ${PAPER_BASE}
	${LATEX_TOOL} ${PAPER_BASE}
	${LATEX_TOOL} ${PAPER_BASE}
#	${DVIPDF_TOOL} ${PAPER_BASE}

view: ${TARGETS}
	${VIEW_TOOL} $?

clean:
	rm -f *.aux *.log *.dvi *.pdf *.bbl *.blg
	$(MAKE) $(MFLAGS) -C plots clean
