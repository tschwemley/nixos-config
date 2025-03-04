{writeShellScriptBin}:
writeShellScriptBin "rotate-sops-file"
/*
bash
*/
''
  [[ -z "$1" ]] && echo "missing path to a sops-encrypted file."
  file=$1
  sops --in-place -d $file && sops --in-place -e $file
''
