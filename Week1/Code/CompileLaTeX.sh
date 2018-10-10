#!/bin/bash
# Author: Danielle Norman
# Date: Oct 2018
# Description: compiles LaTeX file $1.tex, opens the created pdf and
# removes the extra files created

pdflatex $1.tex
pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex
evince $1.pdf &

## Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc
rm *.bbl
rm *.blg


