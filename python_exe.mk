#==============================================================================
#D Requires $(TARGET)
#D This will make a temporary setup.py file which it will the run using py2exe
#D and this will create a dist folder with the required dlls in it.
#------------------------------------------------------------------------------

MAKE_SETUP = $(shell echo "from distutils.core import setup" > setup.py && \
 echo "import py2exe" >> setup.py && \
 echo "setup(console=['$(TARGET).py'])" >> setup.py \
)

REMOVE_TEMP_FILES = @rm -f *.pyc setup.py *~

#==============================================================================
#D dist folder will be created including dlls etc.
#------------------------------------------------------------------------------
dist/$(TARGET).exe: $(TARGET).py
	$(MAKE_SETUP)
	/c/Python27/python.exe setup.py py2exe
	$(REMOVE_TEMP_FILES)
