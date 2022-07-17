# poke bytes example

This example shows how to parse multiple bytes appended to a SYS command with comma delimiters.  (The 16-bit unsigned number/address parsing was also shown in part two.)  See source for assembly code and comments.

Demo usage:

Mount poke_bytes.d64 disk

    LOAD"poke bytes",8,1
    NEW
    SYS 49192, 1024, 1,2,3,4,5 : REM POKE bytes to address 1024

![Part three example C64 screen](https://github.com/davervw/extend-c64-BASIC/raw/master/part-three-poke-multiple-bytes/media/pokebytes.png)

Source code is 6502 assembler targeting Commodore 64

Requires bin/win/[acme.exe](https://sourceforge.net/projects/acme-crossass/) and bin/win/c1541.exe from [Vice](http://vice-emu.sourceforge.net/index.html#download)
and revise build.sh to use more Vice executables for building and launching

Also see [blog entry](https://techwithdave.davevw.com/2022/07/extending-c64-basic-part-three-poke.html)
