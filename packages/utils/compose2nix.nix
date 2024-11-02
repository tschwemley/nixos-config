{
  writeShellScriptBin,
  compose2nix,
}:
writeShellScriptBin "compose2nix"
/*
bash
*/
''
  [ -z "$1" ] && echo "must pass in a path" && exit 1

  compose2nix="${compose2nix}/bin/compose2nix"

  [ "$1" == "help" ] && $compose2nix --help && exit 0
  [ ! -d "$1" ] && echo "path does not exist: $1" && exit 1

  $compose2nix \
    -inputs "$1/compose.yaml" \
    -output "$1/default.nix" \
    -runtime podman \
    -write_nix_setup=false
''
