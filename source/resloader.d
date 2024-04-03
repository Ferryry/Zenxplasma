module resloader;

import std.stdio;
import std.file;
import std.conv;

ubyte[] readBytesFromFile(dstring _file) => readBytesFromFile(to!string(_file));

/// 
/// Params:
///   _file = Path of the file
/// Returns: ubyte[]
ubyte[] readBytesFromFile(string _file)
{
    try
    {
        auto file = File(_file, "rb");

        if (!file.isOpen)
        {
            return null;
        }

        ubyte[] buffer;
        buffer.reserve(1024);

        while (!file.eof())
        {
            buffer ~= file.readln().dup;
        }

        file.close();

        return buffer;
    }
    catch (Exception e)
    {
        return null;
    }
}

string[] readLinesFromFile(dstring _file) => readLinesFromFile(to!string(_file));

/// 
/// Params:
///   _file = Path of the file
/// Returns: string[]
string[] readLinesFromFile(string _file)
{
    try
    {
        auto file = File(_file, "r");

        if (!file.isOpen)
        {
            return null;
        }

        string[] lines;

        foreach (line; file.byLine())
        {
            lines ~= line.dup;
        }

        file.close();

        return lines;
    }
    catch (Exception e)
    {
        return null;
    }
}