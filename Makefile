#
# #INFO: Makefile for mcidoc
#
# ------------------------------------------------------------------------------
#
# Author: DTMc
#
# This file is part of mcidoc.
#
# mcidoc is free software: you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# mcidoc is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# ------------------------------------------------------------------------------


# DEFINE VARIABLES -------------------------------------------------------------

EXAMPLE-THESIS := BSc-Thesis MSc-Company-Thesis MSc-Double-Degree

distribute:
# #:INFO: Generate template Thesis for specific scenarios

	for dir in ${EXAMPLE-THESIS} ; do \
		cp -f src/mcidoc.cls ${PWD}/examples/Thesis/$$dir/mcidoc.cls; \
	done

PHONY: clean

clean:
# #:INFO: Cleans all the temporary files within given directory from compilation.


	@echo "Cleaning the directory of undesirables..."
	@find . \
	\( \
	   -name "*.maf"  -o -name "*.mtc"  -o -name "*.cp"   -o -name "*.fn"      \
    -o -name "*.glo"  -o -name "*.ist"  -o -name "*.out"  -o -name "*.acn"     \
    -o -name "*.acr"  -o -name "*.alg"  -o -name "*.bcf"  -o -name "*.slg"     \
	-o -name "*.loth" -o -name "*.fls"  -o -name "*.fdb*" -o -name "*.blg"     \
    -o -name "*.syg"  -o -name "*.syi"  -o -name "*.symc" -o -name "*.syml"    \
	-o -name "_region_.aux" \
	-o -name "*.aux" \
	-o -name "*.glsdefs"    \
	-o -name "_region_.tex" \
	-o -name "*-blx.aux" \
	-o -name "*-blx.bbl" \
	-o -name "*.glg"  -o -name "*.glo"  -o -name "*.idx"  -o -name "*.idv"     \
	-o -name "*.lg"   -o -name "*.dvi"  -o -name "*.ilg"  -o -name "*.ind"     \
	-o -name "*.gls"  -o -name "*.loe"  -o -name "*.bbl"  -o -name "*-blx.bib" \
	-o -name "*.log"  -o -name "*.gz"   -o -name "*.run.xml"                   \
	-o -name "*.nav"  -o -name "*.vrb"  -o -name "*.comment"                   \
	-o -name "*.output" \
	-o -name "*.pytxcode"               -o -name "*.pyg"  -o -name "*.toc"     \
	-o -name "*.lot"  -o -name "*.lof"  -o -name "*.snm"  -o -name "*.xref"    \
	-o -name "*.tmp"  -o -name "*.mtc0" -o -name "#*.*#"  -o -name "*.4ct"     \
	-o -name "*.4tc"  -o -name "*.lms"  -o -name "*.0x.svg" \
	-o -name "*.abs" \
	-o -name "*.ack" \
	\) \
	-type f -delete

# ------------------------------------------------------------------------------
# Makefile ends here.
#
#
