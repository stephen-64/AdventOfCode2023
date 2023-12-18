module numberconversions;
import std.stdio;
import std.conv;
import std.traits;
import std.string;

enum NUMBERCONVERSIONS : int
{
    one = 1,
    two = 2,
    three = 3,
    four = 4,
    five = 5,
    six = 6,
    seven = 7,
    eight = 8,
    nine = 9
}

int checkStringForNumberName(string wordToCheck)
{
    foreach(member ; EnumMembers!NUMBERCONVERSIONS)
    {
        if (wordToCheck.indexOf(member) > -1)
        {
            return member;
        }
    }
    return -1;
}