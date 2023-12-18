import std.stdio;
import std.ascii;


import engineschematic;


void main()
{
	//File theMap = File("testinput.txt", "r");
	File theMap = File("input.txt", "r");
	string line;
	int lineCounter = 0;
	FullEngineSchmatic newSchematics;
	while ((line = theMap.readln()) !is null)
	{
		newSchematics.schematicLines ~= EngineSchmaticLine(line, lineCounter);
		lineCounter++;
	}
	//writeln(newSchematics.schematicLines);
	writeln(newSchematics.processSchematics());
	writeln(newSchematics.processGears());
}
