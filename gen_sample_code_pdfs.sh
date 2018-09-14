#!/bin/bash
#

set -eu
set -o pipefail

trap 'echo "error:$0($LINENO) \"$BASH_COMMAND\" \"$@\""' ERR

OBJECT_DIR=obj
SOURCE_DIR=src
SOURCE_FILE=src/sample_code.md

function call_pandoc(){
	OPTION_NAME=$1
	HIGHLIGHT_OPTION=$2

	mkdir -p obj
	cp src/sample_code.md obj/${OPTION_NAME}_sample_code.md
	sed -i "s/HIGHLIGHT_STYLE_KIND/${OPTION_NAME}/g" obj/${OPTION_NAME}_sample_code.md

	pandoc \
		obj/${OPTION_NAME}_sample_code.md \
		--read=markdown \
		--latex-engine=lualatex --variable version=2.0 \
		--variable papersize=a5 \
		--variable fontsize=7pt \
		--variable geometry:margin=1.6cm \
		${HIGHLIGHT_OPTION} \
		-o obj/${OPTION_NAME}_sample_code.pdf
}

call_pandoc "listings" "--listings -H src/listings-setup.tex"
# styleとlistingの前後順を入れ替えても結果は変わらなかった
call_pandoc "listings0+espresso" "--highlight-style=espresso --listings -H src/listings0+espresso-setup.tex"

for i in pygments kate monochrome breezeDark espresso zenburn haddock tango; do
	HIGHLIGHT_STYLE_KIND=$i
	call_pandoc "${HIGHLIGHT_STYLE_KIND}" "--highlight-style=${HIGHLIGHT_STYLE_KIND}"
done

