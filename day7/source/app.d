import std.stdio;
import std.string;

import cardmagic.cardgameprocessor;

void main()
{
	//File input = File("testinput.txt");
	File input = File("input.txt");
	string line;
	string[] fileContents;

	while ((line = input.readln()) != null && line != "\n")
	{
		fileContents ~= strip(strip(line, "\n"));
	}
	//writeln(fileContents);

	GameProcessor gameProcessor = GameProcessor(fileContents);
	gameProcessor.loadSortedGameData();
	writeln(gameProcessor.cardGamesData);
	writeln(gameProcessor.calculateTotalGameScores());
}
