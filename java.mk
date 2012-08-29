#==============================================================================
#D Requitres $(EXE).
#D Needs the class wanted provided as EXE and will use javac to make all the 
#D required class files.
#  It requires the following directory structure:
#   +--Folder
#   +--+--class
#   +--+--source
#------------------------------------------------------------------------------

#==============================================================================
#D Makes the java files into class files
#------------------------------------------------------------------------------
class/$(EXE): source/*.java
	cd source && javac -d ../class $(EXE).java
	@echo ""

#==============================================================================
#D Runs the class files
#------------------------------------------------------------------------------
run: class/$(EXE)
# at the moment running through make isn't working, so just echo the command.
	@echo "RUN: java -classpath class $(EXE)"

#==============================================================================
#D Deletes the temporary files.
#------------------------------------------------------------------------------
clean: FRC
	@rm -f */*.class *~ */*~
	@echo "Removing class and temporary files"

#==============================================================================
#D Pseudo target causes all targets that depend on FRC to be remade even in 
#D case a file with the name of the target exists. Works unless there is a file
#D called FRC in the directory.
#------------------------------------------------------------------------------
FRC:
