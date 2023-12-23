module cardmagic.carddata;

import std.conv;
import std.algorithm;
import std.ascii;
import std.stdio;

enum WinningHandType
{
    highCard=1,
    onePair=2,
    twoPairs=3,
    threeOfAKind=4,
    fullHouse=5,
    fourOfAKind=6,
    fiveOfAKind=7
}

enum FaceCards
{
    A=14,
    K=13,
    Q=12,
    J=11,
    T=10
}

struct CardData
{
    string cards;
    long bet;
    long cardScore;
    WinningHandType handType;

    this(string cards, long bet)
    {
        this.cards = cards;
        this.bet = bet;
    }

    void calculateHandTypeAndScore()
    {
        if (cards.length != 5)
        {
            handType = WinningHandType.highCard;
            cardScore = 0;
        }

        int[int] cardCounts;
        cardScore = 0;
        long cardCounter = 100_000_000;
        foreach (char card; cards)
        {
            int cardValue;
            if (isDigit(card))
            {
                cardValue = card - '0';
            }
            else
            {
                cardValue = findFaceCard(card);
            }
            int currentCount = cardCounts.require(cardValue, 0);
            currentCount += 1;
            cardCounts[cardValue] = currentCount;
            cardScore += (cardValue * cardCounter);
            cardCounter /= 100;
        }

        handType = findHandType(cardCounts);
    }

    WinningHandType findHandType(int[int] cardCounts)
    {
        WinningHandType calculatedHandType;
        long uniqueCards = cardCounts.length;
        switch (uniqueCards)
        {
            case 4:
                calculatedHandType = WinningHandType.onePair;
                break;
            case 3:
                if (reduce!(max)(cardCounts.values) > 2)
                {
                    calculatedHandType = WinningHandType.threeOfAKind;
                }
                else
                {
                    calculatedHandType = WinningHandType.twoPairs;
                }
                break;
            case 2:
                if (reduce!(max)(cardCounts.values) > 3)
                {
                    calculatedHandType = WinningHandType.fourOfAKind;
                }
                else
                {
                    calculatedHandType = WinningHandType.fullHouse;
                }
                break;
            case 1:
                calculatedHandType = WinningHandType.fiveOfAKind;
                break;
            default:
                calculatedHandType = WinningHandType.highCard;
        }
        return calculatedHandType;
    }

    FaceCards findFaceCard(char card)
    {
        FaceCards faceCard;
        switch (card)
        {
            case 'A':
                faceCard = FaceCards.A;
                break;
            case 'K':
                faceCard = FaceCards.K;
                break;
            case 'Q':
                faceCard = FaceCards.Q;
                break;
            case 'J':
                faceCard = FaceCards.J;
                break;
            default:
                faceCard = FaceCards.T;
        }    
        return faceCard;
    } 
}



bool cardDataComparator(CardData x, CardData y)
{
    if (x.handType < y.handType)
    {
        return true;
    }
    else if(x.handType > y.handType)
    {
        return false;
    }
    else return x.cardScore < y.cardScore;
}
