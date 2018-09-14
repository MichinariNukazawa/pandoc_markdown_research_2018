#
#
#
MKDIR_P		:= mkdir -p

SOURCE_DIR		:= src
OBJECT_DIR	:= obj
BOOK_FILE	:= pandoc_markdown_research_2018.pdf

.PHONY : all clean

.PHONY : book
all : book

clean :
	rm -rf $(OBJECT_DIR)

.PHONY : opens pdfs
pdfs : src/sample_code.md ./gen_sample_code_pdfs.sh
	./gen_sample_code_pdfs.sh

opens : pdfs
	evince $(OBJECT_DIR)/*_sample_code.pdf 2>&1 > /dev/null &

$(OBJECT_DIR)/Content.pdf : README.md Makefile *.sh
	$(MKDIR_P) $(OBJECT_DIR)
	bash ./preprocess.sh $(OBJECT_DIR) README.md
	# 本文PDFを生成
	pandoc \
		$(OBJECT_DIR)/README.md \
		-N --variable  fontsize=9pt --latex-engine=lualatex --variable version=2.0 \
		 -V documentclass=ltjsarticle -N \
		-V papersize=b5 \
		--read=markdown+footnotes+implicit_figures \
		-o $(OBJECT_DIR)/Content.pdf

book : $(BOOK_FILE)
#$(BOOK_FILE) : pdfs
$(BOOK_FILE) : *.md $(SOURCE_DIR)/*.md $(SOURCE_DIR)/*.pdf $(SOURCE_DIR)/*tex $(OBJECT_DIR)/*.pdf Makefile
	# サンプルPDFを手作業で作成
	# make pdfs
	# サンプルpdfをtexで結合可能にリネーム
	rm -rf $(OBJECT_DIR)/print
	$(MKDIR_P) $(OBJECT_DIR)/print
	cp $(OBJECT_DIR)/*.pdf $(OBJECT_DIR)/print/
	cd $(OBJECT_DIR)/print/ && rename "s/_/-/g" *.pdf
	cd $(OBJECT_DIR)/print/ && rename "s/_/-/g" *.pdf
	cd $(OBJECT_DIR)/print/ && rename "s/_/-/g" *.pdf
	# 表紙背表紙を結合
	cp $(SOURCE_DIR)/pandoc_markdown_research_2018.tex  $(OBJECT_DIR)/
	cp $(SOURCE_DIR)/*.pdf $(OBJECT_DIR)/
	cd $(OBJECT_DIR) && pdflatex -halt-on-error -interaction=nonstopmode -file-line-error pandoc_markdown_research_2018.tex
	cp $(OBJECT_DIR)/pandoc_markdown_research_2018.pdf $@

open : all
	evince $(BOOK_FILE) 2>&1 > /dev/null &

