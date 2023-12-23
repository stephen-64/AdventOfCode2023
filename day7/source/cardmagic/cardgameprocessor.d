module cardmagic.cardgameprocessor;

import cardmagic.carddatajoker;
import std.string;
import std.conv;
import std.algorithm.sorting;

struct GameProcessor
{
    string[] cardGames;
    CardData[] cardGamesData;
    long totalWinnings = 0;

    this(string[] cardGames)
    {
        this.cardGames = cardGames;
    }

    void loadSortedGameData()
    {
        foreach (string game; cardGames)
        {
            string[] gameInfo = split(game, " ");
            if (gameInfo.length == 2)
            {
                CardData cardData = CardData(gameInfo[0], to!long(gameInfo[1]));
                cardData.calculateHandTypeAndScore();
                cardGamesData ~= cardData;
            }
        }
        sort!cardDataComparator(cardGamesData);
    }

    long calculateTotalGameScores()
    {
        for (long gameCount = 1; gameCount <= cardGamesData.length; gameCount++)
        {
            totalWinnings += (cardGamesData[gameCount - 1].bet * gameCount);
        }
        return totalWinnings;
    } 
}