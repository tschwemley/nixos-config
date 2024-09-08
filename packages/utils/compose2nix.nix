{
  writeShellScriptBin,
  compose2nix,
}:
writeShellScriptBin "compose2nix" # bash
  ''
    [ -z "$1" ] && echo "must pass in container dir name" && exit 1

    compose2nix="${compose2nix}/bin/compose2nix"
    containerPath="/home/schwem/nixos-config/containers/$1"

    [ "$1" == "help" ] && $compose2nix --help && exit 0
    [ ! -d "$containerPath" ] && echo "path does not exist: $containerPath" && exit 1

    $compose2nix \
      -inputs "$containerPath/compose.yaml" \
      -output "$containerPath/default.nix" \
      -runtime podman \
      -write_nix_setup=false
  ''
