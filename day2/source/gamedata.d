module gamedata;

import std.string;
import std.stdio;
import std.conv;

class GameData
{
    private string gameDataToParse;
    int gameId;
    int maxRedCount = 0;
    int maxGreenCount = 0;
    int maxBlueCount = 0;

    private enum PossibleColors
    {
        red,
        green,
        blue
    }

    this(string gameData)
    {
        gameDataToParse = gameData;
    }

    void convertGameDataToCounts()
    {
        string[] splitOnColon = split(gameDataToParse, ":");
        string splitOnGame = strip(splitOnColon[0], "Game ");
        gameId = to!int(splitOnGame);
        string[]  splitOnSemiColon = split(splitOnColon[1], ";");
        string[] tempGameStates;
        foreach (string gameOutcomes; splitOnSemiColon)
        {
            tempGameStates = split(gameOutcomes, ",");
            foreach (string gameStates; tempGameStates)
            {
                string[] numberColorSplit = split(strip(gameStates), " ");
                //writeln(numberColorSplit);
                string color = numberColorSplit[1];
                switch(to!PossibleColors(color))
                {
                    case PossibleColors.red:
                    {
                        int currentRedCount = to!int(numberColorSplit[0]);
                        if (maxRedCount < currentRedCount)
                        {
                            maxRedCount = currentRedCount;
                        }
                        break;
                    }
                    case PossibleColors.green:
                    {
                        int currentGreenCount = to!int(numberColorSplit[0]);
                        if (maxGreenCount < currentGreenCount)
                        {
                            maxGreenCount = currentGreenCount;
                        }
                        break;
                    }
                    case PossibleColors.blue:
                    {
                        int currentBlueCount = to!int(numberColorSplit[0]);
                        if (maxBlueCount < currentBlueCount)
                        {
                            maxBlueCount = currentBlueCount;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
        }
    }

    bool checkIfValidGame(int totalRedCount, int totalGreenCount, int totalBlueCount)
    {
        if(maxRedCount <= totalRedCount && 
        maxGreenCount <= totalGreenCount && 
        maxBlueCount <= totalBlueCount)
        {
            return true;
        }
        return false;
    }

    const{
        override string toString()
        {
            return "Game Id: " ~ 
            to!string(gameId) ~ 
            " Total Reds: " ~
            to!string(maxRedCount) ~ 
            " Total Green: " ~
            to!string(maxGreenCount) ~ 
            " Total Blue: " ~
            to!string(maxBlueCount);
        }
    }
}