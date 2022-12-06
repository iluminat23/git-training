SVGFILES := $(wildcard *.svg)

all: $(SVGFILES:%.svg=%.pdf)

clean:
	rm -f *.pdf

%.pdf: %.svg
	inkscape --export-type="pdf" -d 300 $*.svg
