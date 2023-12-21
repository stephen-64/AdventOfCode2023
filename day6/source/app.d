import std.stdio;
import std.string;
import std.conv;
import std.regex;

void main()
{
	//File input = File("testinput.txt");
	File input = File("input.txt");
	string fileContents;
	string line;
	while ((line = input.readln()) != null)
	{
		fileContents ~= line;
	}
	long[long] racePatterns = calculateRacePatterns(fileContents);
	write("The race patterns we found were as follows: ");
	writeln(racePatterns);
	long[] validOutcomesPerRace;
	foreach (long time, long distance; racePatterns)
	{
		validOutcomesPerRace ~= numberOfValidOutcomes(time, distance);
	}
	write("The valid outcomes for each of those races were as follows: ");
	writeln(validOutcomesPerRace);
	write("Multiplying these together gives: ");
	double finalResults = 1;

	foreach (long outcomes; validOutcomesPerRace)
	{
		finalResults *= outcomes;
	}
	writeln(to!int(finalResults));
	string[] raceSplit = splitLines(fileContents);
	string fullTime = cleanDistanceAndTimeFromFile(raceSplit[0]);
	string fullDistance = cleanDistanceAndTimeFromFile(raceSplit[1]);
	long fullTimeNumber = to!long(fullTime);
	long fullDistanceNumber = to!long(fullDistance);
	writeln("The real race time and distnace was: " ~ fullTime ~ " ms with a distance of " ~ fullDistance ~ " mm");
	writeln("The number of possible outcomes was: " ~ 
		to!string(numberOfValidOutcomes(fullTimeNumber, fullDistanceNumber)));
}

string cleanDistanceAndTimeFromFile(string fileData)
{
	return strip(replace(strip(strip(fileData, "Time:"), "Distance:"), " ", ""));
}

long[long] calculateRacePatterns(string raceData)
{
	string[] raceSplit = splitLines(raceData);
	Regex!char stringReplacePattern = regex(" +");
	string[] times = split(strip(replaceAll(strip(raceSplit[0], "Time:"), stringReplacePattern, " ")), " ");
	string[] distances = split(strip(replaceAll(strip(raceSplit[1], "Distance:"), stringReplacePattern, " ")), " ");

	long[long] racePatterns;

	for (long countOfRaceTimes = 0; countOfRaceTimes < times.length; countOfRaceTimes++)
	{
		racePatterns[convertRaceDataStringToLong(times[countOfRaceTimes])] = 
			convertRaceDataStringToLong(distances[countOfRaceTimes]);
	}

	return racePatterns;
}

long convertRaceDataStringToLong(string raceLine)
{
	//writeln(raceLine);
	return to!long(strip(raceLine));
}

long numberOfValidOutcomes(long time, long distance)
{
	long validOutcomes = 0;
	for (long startTime = 1; startTime < time; startTime++)
	{
		long endTime = time - startTime;
		long raceDistance = startTime * endTime;
		//writeln(raceDistance);
		if (raceDistance > distance)
		{
			validOutcomes ++;
		}
	}
	return validOutcomes;
}
