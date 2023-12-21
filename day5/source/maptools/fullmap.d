module maptools.fullmap;

import std.string;
import std.algorithm.searching;

import maptools.mapdata;


struct MapProcessor
{
    FullMapSet[] maps;

    this(string[] sourceToDestMaps)
    {
        foreach (string mapsToProcess; sourceToDestMaps)
        {
            maps ~= FullMapSet(split(mapsToProcess, "\n"));
        }
    }

    long returnOverallDestination(long source)
    {
        long lastDestination = source;
        foreach (FullMapSet map; maps)
        {
            lastDestination = map.getDestinationFromSubsets(lastDestination);
        }
        return lastDestination;
    }
}


struct FullMapSet
{
    //FullMapSet* nextMap = null;
    MapDataHolder[] mapData;

    this(string[] mapEntries)
    {
        //this.nextMap = null;
        foreach (string entry; mapEntries)
        {
            if (!canFind(entry, "map") && entry.length > 0)
            {
                mapData ~= MapDataHolder(entry);
            }
        }
    }

    // void setNextMap(FullMapSet* nextMap)
    // {
    //     this.nextMap = nextMap;
    // }

    long getDestinationFromSubsets(long source)
    {
        foreach (MapDataHolder mapInfo; mapData)
        {
            long checkNewDestination = mapInfo.convertSourceToDestination(source);
            if (checkNewDestination != source)
            {
                return checkNewDestination;
            }
        }
        return source;
    }
}