import std.stdio;
import std.string;
import std.conv;

import gamedata;

void main()
{
	//File possibleGames = File("testinput.txt", "r");
	File possibleGames = File("input.txt", "r");
	string line;
	GameData[] allGameStates;

	while ((line = possibleGames.readln()) !is null)
	{
		//writeln(line);
		GameData lineByLineData = new GameData(line);
		lineByLineData.convertGameDataToCounts();
		allGameStates ~= lineByLineData;
	}
	//writeln(allGameStates);

	writeln("Time to play a game!");

	write("Are you solving Question 1 or 2? ");
	int problem = to!int(strip(stdin.readln()));
	if (problem > 1)
	{
		runProblem2(allGameStates);
	}
	else 
	{
		runProblem1(allGameStates);
	}
}

void runProblem2(GameData[] allGameStates)
{
	double sumOfPossibleGameSets = 0;
	foreach (game; allGameStates)
	{
		double fullMultiplication = game.maxRedCount * 
		game.maxGreenCount * 
		game.maxBlueCount;
		sumOfPossibleGameSets += fullMultiplication;
	}
	writeln("The Sum Of Powers Was " ~ to!string(sumOfPossibleGameSets));
}

void runProblem1(GameData[] allGameStates)
{
	int totalIdCount = 0;
	write("How many Red Cubes: ");
	int redCubes = to!int(strip(stdin.readln()));
	write("How many Green Cubes: ");
	int greenCubes = to!int(strip(stdin.readln()));
	write("How many Blue Cubes: ");
	int blueCubes = to!int(strip(stdin.readln()));
	foreach (gameState; allGameStates)
	{
		if (gameState.checkIfValidGame(redCubes, greenCubes, blueCubes))
		{
			//writeln(gameState.gameId);
			totalIdCount += gameState.gameId;
		}
	}
	writeln("The sum of valid game id's was: " ~ to!string(totalIdCount));
	writeln("Thanks for playing");
}
