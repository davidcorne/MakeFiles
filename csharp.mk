#==============================================================================
#D Requires $(EXE)
#D Will recursivly build all the .cs files into it. This requires a directory 
#D structure like this:
#   +--Folder
#   +--+--exe
#   +--+--source
#------------------------------------------------------------------------------

CC = 
CC_OPT = 

# use csc on windows and mcs on linux, option escape key is different.
OS = $(shell uname -o)
ifeq ($(OS), GNU/Linux)
  CC = mcs
  CC_OPTIONS = -
endif
ifeq ($(OS), Cygwin)
  CC = csc
  CC_OPT = /
endif

# show warnings
CC_WARN = $(CC_OPT)warnaserror $(CC_OPT)warn:4 

#==============================================================================
#D Target depending on all .exe files made from a .cs file so that all of them 
#D will be made.
#------------------------------------------------------------------------------
exe/$(EXE).exe: source/*
	$(CC) $(CC_OPT)out:$@ $(CC_WARN) $(CC_OPT)recurse:*.cs
	@echo "$@ made."
	@echo ""

#==============================================================================
#D For deleting all temporary and made files
#------------------------------------------------------------------------------
clean: FRC
	@rm -f  exe/*.exe  *.stackdump source/*~ source/\#*\#
	@echo "Removed all: objects, libraries, executables, and temp files."

#==============================================================================
#D Pseudo target causes all targets that depend on FRC to be remade even in 
#D case a file with the name of the target exists. Works unless there is a file
#D called FRC in the directory.
#------------------------------------------------------------------------------
FRC: