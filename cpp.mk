#==============================================================================
#D Makes the C++ source files into a library and an executable.
#D Requires: $(EXE), $(LIBRARY), $(OBJECTS) and $(INCLUDES).
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

WARN = -Wall -Werror 

OP_FLAGS = -O0 -g -DDEBUG -D_DEBUG -D_WINDOWS

CFLAGS = $(OP_FLAGS) $(WARN) $(INCLUDES)
CC = g++

#==============================================================================
# Rules/Dependencies (all generic)
#------------------------------------------------------------------------------

#==============================================================================
#D Build a the executable 
#D try to get debugging info out for Visual Studio -- currently doesn't work
#------------------------------------------------------------------------------
exe/$(EXE).exe: source/application/$(EXE).cpp lib/$(LIBRARY).lib 
	@mkdir -p exe
	$(CC) $(CFLAGS) source/application/$(EXE).cpp lib/$(LIBRARY).lib \
        -o exe/$(EXE).exe
	@echo ""

#==============================================================================
#D Build the objects into a library
#------------------------------------------------------------------------------
lib/$(LIBRARY).lib: $(OBJECTS) 
	@mkdir -p lib
	ar ruvs $@ $(OBJECTS)
	@echo ""

#==============================================================================
#D Make all the object files and move them to the obj directory
#------------------------------------------------------------------------------
obj/%.o : source/*/%.cpp $(LIBRARY)/%.h 
	@mkdir -p obj
	$(CC) $(CFLAGS) -c $< -o $@
	@echo ""

#==============================================================================
#D For making and running the unit tests
#------------------------------------------------------------------------------
utest: lib/$(LIBRARY).lib
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

