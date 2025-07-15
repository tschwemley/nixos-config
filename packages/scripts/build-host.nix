{
  eza,
  lib,
  writeShellScriptBin,
}:
writeShellScriptBin "build-host"
# bash
''
    hosts=$(${lib.getExe eza} --only-dirs "$HOME/nixos-config/nixos/hosts")
    host=$1

    [ -z "$host" ] && echo "no hostname provided" && exit 1

    no_copy_flag="false"
    [[ "''${1:-""}" == "--no-copy" ]] && no_copy_flag="true"



    function buildHost() {
      [ ! -d "" ]

      nix build .#nixosConfigurations."$1".config.system.build.toplevel -o "$1" --show-trace

      # if --build-only is passed as an option then exit without copying closure
      if [[ "$2" == "--build-only" || "$2" == "--skip-copy" ]]; then
        exit 0
      fi

      nix-copy-closure --to "$1" "$1"
      [ -d "$1" ] && rm "$1"
    }

  # look for host and build, or if "all" is passed for host then build all hosts
    if [ "$host" == "all" ] ; then
      for hostname in "''${hosts[@]}"
      do
        buildHost "$hostname"
      done
    elif [[ "''${hosts[*]}" =~ ''$host ]]; then
      buildHost "$@"
    else
      echo "invalid hostname: $host"
      exit 1
    fi
''
