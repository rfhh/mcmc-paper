LATEX_TOOL  := pdflatex
BIBTEX_TOOL := bibtex
DVIPDF_TOOL := dvipdfm
VIEW_TOOL   := evince
PAPER_BASE  := paper
TARGETS     :=
TARGETS     += paper.pdf

PLOTS	=

PAPER_PART :=
PAPER_PART += $(TARGETS:%.pdf=%.tex)
PAPER_PART += 00-abstract.tex
PAPER_PART += 01-intro.tex
PAPER_PART += 02-related.tex
PAPER_PART += 03-design.tex
PAPER_PART += 04-evaluation.tex
PAPER_PART += 05-conclusion.tex
# add .tex files

.PHONY: clean view all plots

all: $(TARGETS)

$(TARGETS): $(PLOTS)

paper-ieee.pdf: IEEEtran.cls
paper-ieee.pdf: IEEEtranBST/IEEEtran.bst
paper-ieee.pdf: paper.bib

plots:
	$(MAKE) $(MFLAGS) -C plots

export BIBINPUTS=.:./IEEEtranBST/
export BSTINPUTS=.:./IEEEtranBST/

%.pdf: %.tex  ${PAPER_PART}
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
