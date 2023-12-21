module maptools.mapdata;

import std.string;
import std.conv;
import std.stdio;

struct MapDataHolder
{
    long sourceStartRange;
    long sourceEndRange;
    long destinationStart;
    long range;

    this(string mapData)
    {
        //writeln(mapData);
        long[] mapDataToParse = to!(long[])(split(strip(mapData), " "));
        //writeln(mapDataToParse);
        this(mapDataToParse[0], mapDataToParse[1], mapDataToParse[2]);
    }

    this(long destinationStart, long sourceStart, long range)
    {
        this.destinationStart = destinationStart;
        this.sourceStartRange = sourceStart;
        this.range = range - 1;
        this.sourceEndRange = sourceStartRange + this.range;
    }

    long convertSourceToDestination(long source)
    {
        if (source >= sourceStartRange && source <= sourceEndRange)
        {
            long advancementFactor = source - sourceStartRange;
            return destinationStart + advancementFactor;
        }
        return source;
    }
}