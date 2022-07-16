; delay.asm
; Copyright (c) 2022 by David R. Van Wagner
; davevw.com
;
; MIT LICENSE
; 
; Extending C64 BASIC Part Two - Parse Unsigned Integer (16-bit)
; https://techwithdave.davevw.com/2022/07/extending-c64-basic-part-two-parse-16.html
; https://github.com/davervw/extend-c64-BASIC/tree/master/part-two-delay-jiffies
;
; uses ACME Cross Compiler https://sourceforge.net/projects/acme-crossass/

start=$C028 ; machine language org

chkcom=$aefd ; checks for $2c (comma)
frmnum=$ad8a ; evaluate expression, check data type
makadr=$b7f7 ; convert fp to 2 byte integer
alarm=$57    ; storage in zero page space

* = start
    jsr chkcom  ; require comma after SYS address
    jsr frmnum  ; evaluate expression and make sure is a number
    jsr makadr  ; convert to 16-bit unsigned integer in .Y(lo)/.A(hi)

    ; set alarm with interrupts on during critical part, avoiding rollover
    ; jiffy clock ($A2,A1,A0) added with (0,.A,.Y) accounting for carry bits
+   clc ; prepare for addition
    pha ; save bits 8..15
    tya ; transfer bits 0..7
    sei ; disable interrupts
    adc $A2
    sta alarm+2
    pla ; restore bits 8..15
    adc $A1
    sta alarm+1
    lda $A0
    cli ; re-enable interrupts
    adc #0
    sta alarm
 
    ; busy wait !!!
    ; check for alarm, highest byte down, assume interrupts off is fine, will wait for any rollover
    lda alarm
-   cmp $A0
    bne -
    lda alarm+1
-   cmp $A1
    bne -
    lda alarm+2
-   cmp $A2
    bne -

    ; done waiting for delay
    rts
 