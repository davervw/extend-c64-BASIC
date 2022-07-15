# reverse_string example

This example shows how to parse a string expression appended to a SYS command with a comma delimiter.  The source should be relatively self explanatory.

Demo usage:

Mount reverse_string.d64 disk

    LOAD"REVERSE",8,1
    NEW
    SYS 49152,"REVERSE STRING"

![Part one example C64 screen](https://github.com/davervw/extend-c64-BASIC/raw/master/part-one-reverse-string/reverse.png)

Source code is 6502 assembler targeting Commodore 64

Requires bin/win/[acme.exe](https://sourceforge.net/projects/acme-crossass/) and bin/win/c1541.exe from [Vice](http://vice-emu.sourceforge.net/index.html#download)
and revise build.sh to use more Vice executables for building and launching

Also see [blog entry](https://techwithdave.davevw.com/2022/05/extending-c64-basic-part-one-parse.html)
