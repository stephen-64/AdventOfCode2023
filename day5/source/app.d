import std.stdio;
import std.string;
import std.conv;
import std.algorithm.sorting;

import maptools.fullmap;



void main()
{
	//File inputFile = File("testinput.txt");
	File inputFile = File("input.txt");
	string fullFileContents;
	string lineOfFile;
	while ((lineOfFile = inputFile.readln()) != null)
	{
		fullFileContents ~= lineOfFile;
	}
	string[] puzzleDetails = split(fullFileContents, "\n\n");
	long[] seedsToProcess = to!(long[])(split(strip(strip(puzzleDetails[0], "seeds:")), " "));
	string[] mapsToProcess = puzzleDetails[1 .. puzzleDetails.length];
	MapProcessor mapProcessor = MapProcessor(mapsToProcess);
	long[] destinations;

	//writeln("Testing Input Reading: \n" ~ to!string(mapProcessor));
	foreach (long seeds; seedsToProcess)
	{
		destinations ~= mapProcessor.returnOverallDestination(seeds);
	}
	writeln("The ordered destinations for part 1 seeds is: " ~ to!string(sort(destinations)));

	long globalMin = long.max;

	for (int i = 0; i < seedsToProcess.length; i++)
	{
		long minSeedNumber = long.max;
		long maxSeedNumber = 0;
		long baseSeed = seedsToProcess[i];
		i++;
		if (i >= seedsToProcess.length)
		{
			writeln("Something went very wrong with input");
			break;
		}
		long endOfRangeOfSeeds = baseSeed + seedsToProcess[i];
		if (baseSeed < minSeedNumber)
		{
			minSeedNumber = baseSeed;
		}
		if (endOfRangeOfSeeds > maxSeedNumber)
		{
			maxSeedNumber = endOfRangeOfSeeds;
		}
		for (long seed = minSeedNumber; seed < maxSeedNumber; seed++)
		{
			long currentMin = mapProcessor.returnOverallDestination(seed);
			if (currentMin < globalMin)
			{
				globalMin = currentMin;
			}
		}
	}
	
	writeln("The shortest destination for part 2 seeds is: " ~ to!string(globalMin));

}
