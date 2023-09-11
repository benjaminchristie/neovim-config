MAIN := main
SHELL := /bin/bash

all:
	latexmk -pdf $(MAIN) -silent

clean: clean_tmp
	rm -f $(MAIN).{pdf,aux,bbl,blg,log,dvi,fdb_latexmk,fls}

clean_tmp:
	find . -type f \( -name '*.swp' -o -name '*~' -o -name '*.bak' -o -name '.netrwhist' \) -delete

auto: all
