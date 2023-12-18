module engineschematic;

import std.string;
import std.ascii;
import std.conv;
import std.container.rbtree;
import std.stdio;
import std.algorithm.searching;


struct EngineSchmaticEntry
{
    char schematicEntry;
    int surroundingNumbers = -1;

    this(char schematicEntry)
    {
        this.schematicEntry = schematicEntry;
        if (schematicEntry != '.')
        {
            surroundingNumbers = -2;
        }
        if (schematicEntry == '*')
        {
            surroundingNumbers = -3;
        }
    }

    this(char schematicEntry, int surroundingNumbers)
    {
        this.schematicEntry = schematicEntry;
        this.surroundingNumbers = surroundingNumbers;
    }
}

struct EngineSchmaticLine
{
    string lineOfSchematic;
    EngineSchmaticEntry[] schematicEntries;

    this(string lineOfSchematic, int line)
    {
        this.lineOfSchematic = strip(strip(lineOfSchematic), "/n");
        string numberTrain = "";
        foreach (schematicEntry; this.lineOfSchematic)
        {
            if (isDigit(schematicEntry))
            {
                numberTrain ~= schematicEntry;
            }
            else 
            {
                if (!empty(numberTrain))
                {
                    int number = to!int(numberTrain);
                    foreach (digit; numberTrain)
                    {
                        schematicEntries ~= EngineSchmaticEntry(digit, number);
                    }
                    numberTrain = "";
                }
                schematicEntries ~= EngineSchmaticEntry(schematicEntry);
            }
        }
        if (!empty(numberTrain))
        {
            int number = to!int(numberTrain);
            foreach (digit; numberTrain)
            {
                schematicEntries ~= EngineSchmaticEntry(digit, number);
            }
            numberTrain = "";
        }
    }
}

struct FullEngineSchmatic
{
    EngineSchmaticLine[] schematicLines;

    int processSchematics()
    {
        int[] partNumbers;
        for (int i = 0; i < schematicLines.length; i++)
        {
            EngineSchmaticLine schematicLine = schematicLines[i]; 
            for (int j = 0; j < schematicLine.schematicEntries.length; j++)
            {
                EngineSchmaticEntry schematicEntry = schematicLine.schematicEntries[j]; 
                if (schematicEntry.surroundingNumbers < -1)
                {
                    for (int y=-1; y<=1; y++)
                    {
                        int currentY = i + y;
                        //writeln(currentY);
                        if (currentY >= 0 && currentY < schematicLines.length)
                        {
                            bool hitNonNumber = true;
                            for (int x=-1; x<=1; x++)
                            {
                                int currentX = j + x;
                                //writeln(currentX);
                                if (currentX >= 0 && currentX < schematicLines[currentY].schematicEntries.length)
                                {
                                    int currentNumber = schematicLines[currentY]
                                    .schematicEntries[currentX]
                                    .surroundingNumbers;
                                    if (currentNumber >= 0)
                                    {
                                        if (hitNonNumber)
                                        {
                                            partNumbers ~= currentNumber;
                                            hitNonNumber = false;
                                        }
                                    }
                                    else
                                    {
                                        hitNonNumber = true;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        int runningTotal = 0;
        foreach (int part; partNumbers)
        {
            runningTotal += part;
        }
        return runningTotal;
    }

    int processGears()
    {
        int[] partNumbers;
        for (int i = 0; i < schematicLines.length; i++)
        {
            EngineSchmaticLine schematicLine = schematicLines[i]; 
            for (int j = 0; j < schematicLine.schematicEntries.length; j++)
            {
                EngineSchmaticEntry schematicEntry = schematicLine.schematicEntries[j]; 
                if (schematicEntry.surroundingNumbers == -3)
                {
                    int[] currentPartNumbers;
                    for (int y=-1; y<=1; y++)
                    {
                        int currentY = i + y;
                        //writeln(currentY);
                        if (currentY >= 0 && currentY < schematicLines.length)
                        {
                            bool hitNonNumber = true;
                            for (int x=-1; x<=1; x++)
                            {
                                int currentX = j + x;
                                //writeln(currentX);
                                if (currentX >= 0 && currentX < schematicLines[currentY].schematicEntries.length)
                                {
                                    int currentNumber = schematicLines[currentY]
                                    .schematicEntries[currentX]
                                    .surroundingNumbers;
                                    if (currentNumber >= 0)
                                    {
                                        if (hitNonNumber)
                                        {
                                            currentPartNumbers ~= currentNumber;
                                            hitNonNumber = false;
                                        }
                                    }
                                    else
                                    {
                                        hitNonNumber = true;
                                    }
                                }
                            }
                        }
                    }
                    if (currentPartNumbers.length == 2)
                    {
                        partNumbers ~= currentPartNumbers[0] * currentPartNumbers[1];
                    }
                }
            }
        }
        int runningTotal = 0;
        foreach (int part; partNumbers)
        {
            runningTotal += part;
        }
        return runningTotal;
    }
}