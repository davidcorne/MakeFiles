#==============================================================================
#D Make the tex file into a pdf.
#D Need to provide: TEX_NAME
#------------------------------------------------------------------------------

OUTPUT_NAME = $(shell echo $(TEX_NAME) | sed -e 's/_/\\ /g')

# common commands
REMOVE_TEMP_FILES = @rm -f *.aux *.out *.log *.snm *.nav *.toc *.synctex.gz *.exe.stackdump #*# *~ *.pyc
MAKE_PDF = @pdflatex $(TEX_NAME).tex -job-name=$(OUTPUT_NAME)

# set a different PDF opening command for each OS
OS := $(shell uname -o)
OPEN_PDF = 

ifeq ($(OS), GNU/Linux)
  OPEN_PDF = @evince
endif
ifeq ($(OS), Cygwin)
  OPEN_PDF = @cygstart
endif

#==============================================================================
#D Opens the created pdf
#------------------------------------------------------------------------------
open: $(OUTPUT_NAME).pdf
# Remove temporary/unecessary files
	$(REMOVE_TEMP_FILES)
	$(OPEN_PDF) $(OUTPUT_NAME).pdf &

#==============================================================================
#D Makes the pdf
#------------------------------------------------------------------------------
$(OUTPUT_NAME).pdf: $(TEX_NAME).tex
	$(MAKE_PDF)
	@echo -e "\033[01;32;40m"
	@echo "PDF made."
	@echo -e "\033[01;37;40m"

#==============================================================================
#D Makes the pdf twice so that 
#------------------------------------------------------------------------------
refs: FRC
# make twice so that the references/labels/contents are correct
	$(MAKE_PDF)
	@echo -e "\n\n"
	@echo -e "\033[01;32;40m"
	@echo "First round of making PDF."
	@echo -e "\033[01;37;40m"
	@echo -e "\n\n"
	$(MAKE_PDF)
	@echo -e "\033[01;32;40m"
	@echo "PDF made twice."
	@echo -e "\033[01;37;40m"
# Remove temporary/unecessary files
	$(REMOVE_TEMP_FILES)
	$(OPEN_PDF) $(OUTPUT_NAME).pdf &

#==============================================================================
#D Removes temporary files pdfs and python bytefiles.
#------------------------------------------------------------------------------
clean: FRC
# remove the temporary files
	$(REMOVE_TEMP_FILES)
	@rm -f *.pdf *.pyc
	@echo "Removed all: pdfs, LaTex rubbish and temp files."

#==============================================================================
#D Pseudo target causes all targets that depend on FRC to be remade even in 
#D case a file with the name of the target exists. Works unless there is a file
#D called FRC in the directory.
#------------------------------------------------------------------------------
FRC:


