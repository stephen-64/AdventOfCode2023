import std.stdio;
import std.conv;

import numberconversions;

void main()
{
	File file = File("input.txt", "r");
	//File file = File("testinput.txt", "r");
	//File file = File("testinput2.txt", "r");
	string line;
	int[] numbersFromFile;
	while ((line = file.readln()) !is null)
	{
		writeln(findNumbers(line));
		numbersFromFile ~= findNumbers(line);
	}
	long sum = 0;
	foreach (int number; numbersFromFile)
	{
		sum += number;
	}
	writeln(sum);
}

int findNumbers(string inputString)
{
	int firstInt, lastInt;
	string currentWord = "";
	for(long i = 0; i < inputString.length; i++)
	{
		try
		{
			currentWord ~= inputString[i];
			int testInt = checkStringForNumberName(currentWord);
			if(testInt != -1)
			{
				//writeln(currentWord);
				//writeln(testInt);
				firstInt = testInt;
				break;
			}
			testInt = to!int(to!string(inputString[i]));
			firstInt = testInt;
			break;
		}
		catch(ConvException)
		{
			continue;
		}

	}
	currentWord = "";
	for(long i = inputString.length - 1; i >= 0; i--)
	{
		try
		{
			currentWord = inputString[i] ~ currentWord;
			int testInt = checkStringForNumberName(currentWord);
			if(testInt != -1)
			{
				//writeln(currentWord);
				//writeln(testInt);
				lastInt = testInt;
				break;
			}
			testInt = to!int(to!string(inputString[i]));
			lastInt = testInt;
			break;
		}
		catch(ConvException)
		{
			continue;
		}

	}
	return to!int(to!string(firstInt) ~ to!string(lastInt));
}

int oldFindNumbers(string inputString)
{
	int firstInt, lastInt;
	for(long i = 0; i < inputString.length; i++)
	{
		try
		{
			int testInt = to!int(to!string(inputString[i]));
			firstInt = testInt;
			break;
		}
		catch(ConvException)
		{
			continue;
		}

	}
	for(long i = inputString.length - 1; i >= 0; i--)
	{
		try
		{
			int testInt = to!int(to!string(inputString[i]));
			lastInt = testInt;
			break;
		}
		catch(ConvException)
		{
			continue;
		}

	}
	return to!int(to!string(firstInt) ~ to!string(lastInt));
}