export ACME=/c/Users/Dave/Downloads/acme0.96.4win/acme/ACME_Lib 
export VICE=/c/Users/Dave/Downloads/GTK3VICE-3.3-win32/GTK3VICE-3.3-win32-r35872
bin/win/acme -f cbm -l build/labels -o build/reverse.prg code/reverse.asm
[ $? -eq 0 ] || exit 1
[ $? -eq 0 ] && ${VICE}/c1541 << EOF
attach build/reverse_string.d64
delete "reverse"
delete "reverse.asm"
write build/reverse.prg "reverse"
write code/reverse.asm reverse.asm,s
EOF
#[ $? -eq 0 ] && cp build/reverse_string.d64 /c/Users/Dave/Dropbox/Commodore/
[ $? -eq 0 ] && ${VICE}/x64.exe -moncommands build/labels build/reverse_string.d64
