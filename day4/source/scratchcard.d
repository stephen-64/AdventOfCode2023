module scratchcard;

import std.string;
import std.stdio;
import std.conv;
import std.algorithm.searching;
import std.math.exponential;

struct ScratchCardInfo
{
    int cardNumber;
    int[] winningNumbers;
    int[] yourNumbers;
    int numberOfWins = -1;
    int cardCounts = 0;
    int winScore = 0;

    this(string lineToParse)
    {
        string[] removeCardId = split(strip(lineToParse, "\n"), ":");
        cardNumber = to!int(split(removeCardId[0])[1]);
        string[] numbersToProcess = split(removeCardId[1], "|");
        winningNumbers = to!(int[])(split(strip(numbersToProcess[0])));
        yourNumbers = to!(int[])(split(strip(numbersToProcess[1])));
    }

    void generateWinAndCardCounts()
    {
        foreach (int number; yourNumbers)
        {
            if (canFind(winningNumbers, number))
            {
                numberOfWins++;
                cardCounts++;
            }
        }
    }

    int processNumbers()
    {
        // writeln(winningNumbers);
        // writeln(yourNumbers);
        generateWinAndCardCounts();
        if (numberOfWins >= 0)
        {
            winScore = pow(2, numberOfWins);
            // writeln(winScore);
        }
        return winScore;
    }
}

int processSetOfCards(ScratchCardInfo[] cards)
{
    int total = 0;
    foreach (ScratchCardInfo card; cards)
    {
        total += card.processNumbers();
    }
    // writeln(total);
    return total;
}

unittest
{
	File testInput = File("testinput.txt");
	string line;
	ScratchCardInfo[] cards;
	while ((line = testInput.readln()) !is null)
	{
		cards ~= ScratchCardInfo(line);
	}
	assert(processSetOfCards(cards) == 13);
}

int findCardCounts(ScratchCardInfo[] cards)
{
    immutable ulong maxCardNumber = cards.length;
    int cardCount = 0;
    int[int] cardCounts;

    foreach (ScratchCardInfo card; cards)
    {
        card.generateWinAndCardCounts();
        int timesToRunCurrentCard = cardCounts.require(card.cardNumber, 1);
        for (int timesToRun = 0; timesToRun < timesToRunCurrentCard; timesToRun++)
        {
            // writeln(card);
            for (int i = card.cardCounts; i > 0; i--)
            {
                int cardToDuplicate = card.cardNumber + i;
                if (cardToDuplicate <= maxCardNumber)
                {
                    cardCounts[cardToDuplicate] = cardCounts.require(cardToDuplicate, 1) + 1;
                }
            }
        }
    }

    //writeln(cardCounts);

    foreach (int counts; cardCounts.values)
    {
        cardCount += counts;
    }

    return cardCount;
}

unittest
{
    File testInput = File("testinput.txt");
	string line;
	ScratchCardInfo[] cards;
	while ((line = testInput.readln()) !is null)
	{
		cards ~= ScratchCardInfo(line);
	}
	assert(findCardCounts(cards) == 30);
}