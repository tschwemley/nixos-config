{ writeShellScriptBin }:
writeShellScriptBin "search-nf" /* bash */ ''
  pattern="nf-\w*-.*?''${1}"
  res=$(curl -sL 'https://nerdfonts.com/cheat-sheet' \
       | rg "$pattern" \
       | awk -F'"' '{printf "| %c | %s |\n", strtonum("0x" $4), $2}'
  )


  cat <<MARKDOWN
  | Icon | NF Class  |
  | :--- | :-------  |
  $res
  MARKDOWN
''
