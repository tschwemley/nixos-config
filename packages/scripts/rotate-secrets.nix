{
  coreutils,
  lib,
  scripts,
  writeScriptBin,
  zsh,
}:
writeScriptBin "rotate-secrets"
/*
bash
*/
''
  #!${zsh}/bin/zsh
  SECRET_PATH=~/nixos-config/secrets

  function printUsage() {
    cat <<ENDUSAGE
  Usage: rotate-secrets [TARGET]

  Arguments:
    [TARGET]...
      The target secret file(s) to rotate. At least one target must be provided.
      The target is relative to <nixos_config>/secrets and directory names will be traversed.
      When all or secrets is passed for the target all secrets in the secrets dir will be rotated.

      e.g. server will rotate .../secrets/server/**.
  ENDUSAGE
    exit 1
  }

  function validateTarget() {
    [[ -z "$1" ]] && printUsage

    if [[ ("$1" != "all" && "$1" != "secrets") && ! -d "$SECRET_PATH/$1" && ! -f "$SECRET_PATH/$1" ]]
    then
      printUsage
    fi
  }

  target="$1"
  validateTarget $target
  path="$SECRET_PATH/$target"
  echo "" # TODO: remove

  if [[ -d "$path" ]] ; then
    ${coreutils}/bin/ls -f $path |
    while read -r file; do
      [[ "$file" != "." && "$file" != ".." ]] && ${lib.getExe scripts.rotateSopsFile} "$path/$file"

      [[ $? -eq 0 ]] && echo "Rotated secret: $path/$file"
    done

  elif [[ -f "$path" ]] ; then
    ${lib.getExe scripts.rotateSopsFile} "$path/$file"
    [[ $? -eq 0 ]] && echo "Rotated secret: $path/$file"
  else
    printUsage
  fi
''
