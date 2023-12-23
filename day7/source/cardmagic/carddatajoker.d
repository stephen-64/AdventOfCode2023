module cardmagic.carddatajoker;

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
    J=1,
    T=10
}

struct CardData
{
    string cards;
    long bet;
    long originalCardScore = 0;
    long cardScore;
    WinningHandType handType;
    bool hasJokers = false;

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
        cardScore = 0;
        int[int] cardCounts = updateCardScore(FaceCards.J);
        originalCardScore = cardScore;
        int jUpdate = findIfJNeedsUpdating(cardCounts);
        if (jUpdate != FaceCards.J)
        {
            hasJokers = true;
            cardScore = 0;
            cardCounts = updateCardScore(jUpdate);
        }
        findHandType(cardCounts);
    }

    int[int] updateCardScore(int jValue)
    {
        int[int] cardCounts;
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
            if (cardValue == FaceCards.J && jValue != FaceCards.J)
            {
                cardValue = jValue;
            }
            int currentCount = cardCounts.require(cardValue, 0);
            currentCount += 1;
            cardCounts[cardValue] = currentCount;
            cardScore += (cardValue * cardCounter);
            cardCounter /= 100;
        }
        return cardCounts;
    }

    int findIfJNeedsUpdating(int[int] cardCounts)
    {
        int maxCardType = FaceCards.J;
        int maxCardCount = 0;
        if(canFind(cardCounts.keys, FaceCards.J))
        {
            
            foreach (int cardType, int cardCount; cardCounts)
            {
                if (cardType != FaceCards.J)
                {
                    if (cardCount > maxCardCount)
                    {
                        maxCardType = cardType;
                        maxCardCount = cardCount;
                    }
                    else if (cardCount == maxCardCount)
                    {
                        if (cardType > maxCardCount)
                        {
                            maxCardType = cardType;
                        }
                    }
                }
            }
        }
        return maxCardType;
    }

    void findHandType(int[int] cardCounts)
    {
        WinningHandType calculatedHandType;
        long uniqueCards = cardCounts.length;
        switch (uniqueCards)
        {
            case 1:
                calculatedHandType = WinningHandType.fiveOfAKind;
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
            case 4:
                calculatedHandType = WinningHandType.onePair;
                break;
            default:
                calculatedHandType = WinningHandType.highCard;
        }
        handType = calculatedHandType;
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
    else return (x.originalCardScore < y.originalCardScore);
}
