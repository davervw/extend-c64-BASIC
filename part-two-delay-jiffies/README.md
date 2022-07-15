# delay jiffies example

This example shows how to parse a 16-bit unsigned integer appended to a SYS command with a comma delimiter.  The source should be relatively self explanatory.

Demo usage:

Mount delay_jiffies.d64 disk

    LOAD"DELAY JIFFIES",8,1
    NEW
    SYS 49192,600 : REM about 10 seconds

![Part two example C64 screen](https://github.com/davervw/extend-c64-BASIC/raw/master/part-two-delay-jiffies/media/delay.png)

Source code is 6502 assembler targeting Commodore 64

Requires bin/win/[acme.exe](https://sourceforge.net/projects/acme-crossass/) and bin/win/c1541.exe from [Vice](http://vice-emu.sourceforge.net/index.html#download)
and revise build.sh to use more Vice executables for building and launching

Also see [blog entry](https://techwithdave.davevw.com/2022/07/extending-c64-basic-part-two-parse-16.html)
