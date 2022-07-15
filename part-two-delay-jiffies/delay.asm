; reverse.asm
; Copyright (c) 2022 by David R. Van Wagner
; davevw.com
;
; MIT LICENSE
; 
; Extending C64 BASIC Part Two - Parse String
; 
;
; uses ACME Cross Compiler https://sourceforge.net/projects/acme-crossass/

start=$C028 ; machine language org

chkcom=$aefd ; checks for $2c (comma)
frmnum=$ad8a ; evaluate expression, check data type
makadr=$b7f7 ; convert fp to 2 byte integer
alarm=$57 ; storage in zero page space

* = start
    jsr chkcom
    jsr frmnum
    jsr makadr	; convert to integer

    ; set alarm with interrupts on during critical part, avoiding rollover
+   clc
    pha ; save bits 8..15
    tya ; transfer bits 0..7
    sei
    adc $A2
    sta alarm+2
    pla ; restore bits 8..15
    adc $A1
    sta alarm+1
    lda $A0
    cli
    adc #0
    sta alarm
 
    ; check for alarm, busy wait, highest byte down, assume interrupts off is fine, will wait for any rollover
    lda alarm
-   cmp $A0
    bne -
    lda alarm+1
-   cmp $A1
    bne -
    lda alarm+2
-   cmp $A2
    bne -
    rts
