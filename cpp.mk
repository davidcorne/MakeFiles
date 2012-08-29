#==============================================================================
#D Makes the C++ source files into a library and an executable.
#D Requires: $(EXE), $(LIB), $(OBJECTS) and $(INCLUDES).
#D This also relies on the directory structure being as follows:
#D Directory structure:
# +--Project
# +--+--Project
# +--+--+-- header files
# +--+--source
# +--+--+--application
# +--+--+--+-- application file (with int main() in)
# +--+--+--other folders (normally src)
# +--+--+--+-- normal source files
# +--+--exe
# +--+--+-- executable file
# +--+--lib
# +--+--+-- library file
# +--+--obj
# +--+--+-- object files
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Generic options, can be overridden before the include line.
#------------------------------------------------------------------------------

CFLAGS_D = -O0 -g -DDEBUG -D_DEBUG -D_WINDOWS -Wall -Werror $(INCLUDES)
CFLAGS = -O2
CC = g++

#==============================================================================
# Rules/Dependencies (all generic)
#------------------------------------------------------------------------------

#==============================================================================
#D Build a the executable 
#D try to get debugging info out for Visual Studio -- currently doesn't work
#------------------------------------------------------------------------------
exe/$(EXE).exe: source/application/$(EXE).cpp lib/$(LIB).lib 
	@mkdir -p exe
	$(CC) $(CFLAGS_D) source/application/$(EXE).cpp lib/$(LIB).lib \
        -o exe/$(EXE).exe
	@echo ""

#==============================================================================
#D Build the objects into a library
#------------------------------------------------------------------------------
lib/$(LIB).lib: $(OBJECTS) 
	@mkdir -p lib
	@ar ruvs $(LIB).lib $(OBJECTS)
	@mv $(LIB).lib lib
	@echo ""

#==============================================================================
#D Make all the object files and move them to the obj directory
#------------------------------------------------------------------------------
obj/%.o : source/*/%.cpp $(LIB)/%.h 
	@mkdir -p obj
	$(CC) $(CFLAGS_D) -c $<
	@mv *.o obj
	@echo ""

#==============================================================================
#D For making and running the unit tests
#------------------------------------------------------------------------------
utest: lib/$(LIB).lib
	@make -C utest run
	@echo "Unit tests made and run"

#==============================================================================
#D For deleting all temporary and made files
#------------------------------------------------------------------------------
clean: FRC
	@rm -f obj/*.o lib/* exe/*.exe *.stackdump *~ */*~ #*#
	@echo "Removed all: objects, libraries, executables, and temp files."

#==============================================================================
#D Pseudo target causes all targets that depend on FRC to be remade even in 
#D case a file with the name of the target exists. Works unless there is a file
#D called FRC in the directory.
#------------------------------------------------------------------------------
FRC:

