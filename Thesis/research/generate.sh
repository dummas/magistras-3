#!/usr/bin/env bash

pdflatex main
bibtex main
pdflatex main
pdflatex main
#mv main.pdf main-$(date +%Y-%m-%d-%H-%M).pdf
