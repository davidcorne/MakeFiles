#==============================================================================
#D Requires $(TARGET)
#D This will make a temporary setup.py file which it will the run using py2exe
#D and this will create a dist folder with the required dlls in it.
#------------------------------------------------------------------------------

MAKE_SETUP = $(shell echo "from distutils.core import setup" > setup.py && \
 echo "import py2exe" >> setup.py && \
 echo "setup($(EXE_TYPE)=['$(TARGET).py'])" >> setup.py \
)

REMOVE_TEMP_FILES = @rm -f *.pyc setup.py *~

#==============================================================================
#D dist folder will be created including dlls etc.
#------------------------------------------------------------------------------
dist/$(TARGET).exe: *.py
	$(MAKE_SETUP)
	python setup.py py2exe
	$(REMOVE_TEMP_FILES)
	@rm -rf build

#==============================================================================
#D For deleting all temporary and made files
#------------------------------------------------------------------------------
clean: FRC
	@rm -f *.pyc *~ */*~ #*#
	@rm -rf build dist
	@echo "Removed all: executables, byte compiled files and temp files."

#==============================================================================
#D Pseudo target causes all targets that depend on FRC to be remade even in 
#D case a file with the name of the target exists. Works unless there is a file
#D called FRC in the directory.
#------------------------------------------------------------------------------
FRC:

