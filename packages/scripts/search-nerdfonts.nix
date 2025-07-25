{writeShellScriptBin}:
writeShellScriptBin "search-nf" ''
  curl -sL 'https://nerdfonts.com/cheat-sheet' | rg "$1" | awk -F'"' '{printf "%s -> %c* \n", $2, strtonum("0x" $4)}'
''
