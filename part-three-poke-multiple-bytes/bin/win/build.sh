export ACME=/c/Users/Dave/Downloads/acme0.96.4win/acme/ACME_Lib 
export VICE=/c/Users/Dave/Downloads/GTK3VICE-3.3-win32/GTK3VICE-3.3-win32-r35872
bin/win/acme -f cbm -l build/labels -o build/pokebytes.prg pokebytes.asm
[ $? -eq 0 ] || exit 1
[ $? -eq 0 ] && ${VICE}/c1541 << EOF
attach build/poke_bytes.d64
delete "pokebytes"
delete "pokebytes.asm"
write build/pokebytes.prg "pokebytes"
write pokebytes.asm pokebytes.asm,s
EOF
[ $? -eq 0 ] && ${VICE}/x64.exe -moncommands build/labels build/poke_bytes.d64
