import std.stdio;
import scratchcard;


void main()
{
	writeln("Solution 1");
	File testInput = File("input.txt");
	string line;
	ScratchCardInfo[] cards;
	while ((line = testInput.readln()) !is null)
	{
		cards ~= ScratchCardInfo(line);
	}
	writeln(processSetOfCards(cards));
	writeln("Solution 2");
	writeln(findCardCounts(cards));
}