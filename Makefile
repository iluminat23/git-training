DOC  := git-training.tex

RERUN := "(undefined references|Rerun to get (cross-references|the bars|point totals) right|Table widths have changed. Rerun LaTeX.|Linenumber reference failed)"
RERUNBIB := "No file.*\.bbl|Citation.*undefined"

all: images doc

images:
	@$(MAKE) -C $@

doc: $(DOC:.tex=.pdf)

%.pdf: %.tex
	pdflatex -synctex=1 -interaction=nonstopmode --shell-escape $<
	@egrep -q $(RERUNBIB) $*.log && bibtex $* && pdflatex $<; true
	@egrep -q $(RERUN) $*.log && pdflatex $<; true
	@egrep -q $(RERUN) $*.log && pdflatex $<; true

latexmk:
	-latexmk -pvc -pdf $(DOC)

purge:
	-rm -f *.aux *.dvi *.log *.bbl *.blg *.brf *.fls *.toc *.thm *.out *.fdb_latexmk *.nav *.snm *.synctex.gz *.vrb
	-rm -f _minted-git-training/*
	-rmdir _minted-git-training

clean: purge
	$(MAKE) -C images $@
	-rm -f $(DOC:.tex=.pdf)

.PHONY: all images purge clean

