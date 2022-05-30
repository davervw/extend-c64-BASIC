; reverse.asm
; Copyright (c) 2022 by David R. Van Wagner
; davevw.com
;
; MIT LICENSE
; 
; Extending C64 BASIC Part One - Parse String
; https://techwithdave.davevw.com/2022/05/extending-c64-basic-part-one-parse.html

start=$C000 ; machine language org

chrout=$ffd2

syntax_error=$af08
chkcom=$aefd ; checks for $2c
frmevl=$ad9e ; evaluate expression
pulstr=$b6a3 ; pull string from descriptor stack

* = start
        jsr chkcom
	jsr frmevl	; evaluate expression
	bit $d		; string or numeric?
	bmi +
        jmp syntax_error
+       jsr pulstr	; pull string from descriptor stack (a=len, x=lo, y=hi addr of string)        
        stx $fb
        sty $fc
        tay
        lda #18
        jsr chrout
-       dey
        cpy #$ff
        beq +
        lda ($fb),y
        jsr chrout
        jmp -
+       rts
