{
  lib,
  sops,
  writeShellScriptBin,
}:
writeShellScriptBin "rotate-sops-file"
/*
bash
*/
''
  [[ -z "$1" ]] && echo "missing path to a sops-encrypted file."
  file=$1
  ${lib.getExe sops} --in-place -d "$file"
  ${lib.getExe sops} --in-place -e "$file"
''
