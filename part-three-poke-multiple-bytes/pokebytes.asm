; poke_bytes.asm
; Copyright (c) 2022 by David R. Van Wagner
; davevw.com
;
; MIT LICENSE
; 
; Extending C64 BASIC Part Three - Parse byte values
; https://techwithdave.davevw.com/2022/07/extending-c64-basic-part-three-poke.html
; https://github.com/davervw/part-three-poke-bytes
; uses ACME Cross Compiler https://sourceforge.net/projects/acme-crossass/
;
; example: pokes five bytes (A,B,C,D,E) into consecutive screen memory
; SYS 49240, 1024, 1,2,3,4,5

start=$C058 ; machine language org

chkcom=$aefd ; checks for $2c (comma)
frmnum=$ad8a ; evaluate expression, check data type
makadr=$b7f7 ; convert fp to 2 byte integer
getbytc=$b79b ; parse comma + byte expression from BASIC input
zaddr=$fb    ; storage in zero page space

* = start
    jsr chkcom  ; require comma after SYS address
    jsr frmnum  ; evaluate expression and make sure is a number
    jsr makadr  ; convert to 16-bit unsigned integer in .Y(lo)/.A(hi)
    sty zaddr   ; store as address in zero page 
    sta zaddr+1 ; high byte too

-   jsr getbytc ; check for comma and byte expression
    php         ; save state whether end of statement
    ldy #0      ; always zero index for our purposes
    txa         ; transfer expression byte result to .A
    sta (zaddr),y ; store at specified address
    inc zaddr   ; advance address
    bne +       ; branch if did not overflow
    inc zaddr+1 ; advance high byte if necessary
+   plp         ; retrieve end of statement state
    bne -       ; repeat if not end of statement

    rts         ; done at end of statement
 