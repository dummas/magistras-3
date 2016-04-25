#!/usr/bin/env bash

pdflatex report
bibtex report
pdflatex report
pdflatex report
#mv main.pdf main-$(date +%Y-%m-%d-%H-%M).pdf
