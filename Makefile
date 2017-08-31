.DEFAULT_GOAL := tex
CHAPTERS := $(wildcard chapters/*.tex)
FBMATTERS := $(wildcard fbmatter/*.tex)

proof:
		echo "weasel words: "
		for i in $(CHAPTERS) $(FBMATTERS); do \
		echo "=====" $$i "====="; sh bin/weasel $$i; done; \
		echo
		echo "passive voice: "
		for i in $(CHAPTERS) $(FBMATTERS); do \
		echo "=====" $$i "====="; sh bin/passive $$i; done; \
		echo
		echo "duplicates: "
		for i in $(CHAPTERS) $(FBMATTERS); do \
		echo "=====" $$i "====="; perl bin/dups $$i; done;
tex:
		xelatex thesis.tex
		bibtex thesis
		xelatex thesis.tex
		rm -f thesis-blx.bib thesis.aux thesis.bbl thesis.blg thesis.log thesis.out thesis.run.xml thesis.toc
final:
		bin/delcmdchanges.bash thesis.tex thesis-final.tex
		xelatex thesis-final.tex
		bibtex thesis-final
		xelatex thesis-final.tex