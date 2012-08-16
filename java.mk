#==============================================================================
#D needs the class wanted provided as EXE and will use javac to make all the 
#D required class files.
#  It requires the following directory structure:
#   +--Folder
#   +--+--class
#   +--+--source
#==============================================================================

class/$(EXE): source/*.java
	cd source && javac -d ../class $(EXE).java
	@echo ""

run: class/$(EXE)
	@echo "RUN: java -classpath class $(EXE)"

clean: FRC
	@rm -f */*.class *~ */*~
	@echo "Removing class and temporary files"

FRC:
