.DEFAULT_GOAL := tex
BODYMATTERS := $(wildcard bodymatter/*.tex)
FRONTMATTERS := $(wildcard frontmatter/*.tex)
BACKMATTERS := $(wildcard backmatter/*.tex)

proof:
		echo "weasel words: "
		for i in $(BODYMATTERS) $(FRONTMATTERS); do \
		echo "=====" $$i "====="; sh bin/weasel $$i; done; \
		echo
		echo "passive voice: "
		for i in $(BODYMATTERS) $(FRONTMATTERS); do \
		echo "=====" $$i "====="; sh bin/passive $$i; done; \
		echo
		echo "duplicates: "
		for i in $(BODYMATTERS) $(FRONTMATTERS); do \
		echo "=====" $$i "====="; perl bin/dups $$i; done;
draft:
		xelatex -interaction nonstopmode -file-line-error thesis.tex || true
		biber thesis || true
		xelatex -interaction nonstopmode -file-line-error thesis.tex || true
		xelatex -interaction nonstopmode -file-line-error thesis.tex || true
		#rm -f thesis.aux thesis.log thesis.out thesis.run.xml thesis.toc thesis.bcf thesis.lof thesis.lot thesis.soc acronyms.aux || true
quick:
		xelatex -interaction nonstopmode -file-line-error thesis.tex || true
		#rm -f thesis.aux thesis.bbl thesis.blg thesis.log thesis.out thesis.run.xml thesis.toc thesis.bcf thesis.lof thesis.lot thesis.soc acronyms.aux || true
final:
		#bin/delcmdchanges.bash thesis.tex thesis-final.tex
		xelatex -interaction nonstopmode -file-line-error thesis-final.tex
		biber thesis-final
		xelatex -interaction nonstopmode -file-line-error thesis-final.tex
		xelatex -interaction nonstopmode -file-line-error thesis-final.tex
