export ACME=/c/Users/Dave/Downloads/acme0.96.4win/acme/ACME_Lib 
export VICE=/c/Users/Dave/Downloads/GTK3VICE-3.3-win32/GTK3VICE-3.3-win32-r35872
bin/win/acme -f cbm -l build/labels -o build/delay.prg delay.asm
[ $? -eq 0 ] || exit 1
[ $? -eq 0 ] && ${VICE}/c1541 << EOF
attach build/delay_jiffies.d64
delete "delay jiffies"
delete "delay.asm"
write build/delay.prg "delay jiffies"
write delay.asm delay.asm,s
EOF
[ $? -eq 0 ] && ${VICE}/x64.exe -moncommands build/labels build/delay_jiffies.d64
