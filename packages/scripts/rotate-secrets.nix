{
  writeScriptBin,
  bash,
}:
writeScriptBin "rotate-secrets"
/*
bash
*/
''
  #!${bash}/bin/bash
  find ./secrets/server -type f \( -name "*.env" -o -name "*.yaml" -o -name "*.json" \) -exec sops --in-place -r {} \;
''
