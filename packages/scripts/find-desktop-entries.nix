{writeShellScriptBin}:
writeShellScriptBin "find-desktop-entries"
/*
bash
*/
''
  for p in $\{XDG_DATA_DIRS//:/ }; do
  	[[ ! -d $p/applications ]] && continue
  	find "$p"/applications -name '*.desktop'
  done
''
