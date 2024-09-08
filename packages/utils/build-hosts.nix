{
  self,
  writeShellScriptBin,
}:
writeShellScriptBin "build-host" # bash
  ''
    hosts=(${builtins.toString (builtins.attrNames self.nixosConfigurations)})
    host=$1

    [ -z "$host" ] && echo "no hostname provided" && exit 1

    function buildHost() {
        nix build .#nixosConfigurations.$1.config.system.build.toplevel -o $1
        nix-copy-closure --to $1 $1
        rm $1
    }

    # look for host and build, or if "all" is passed for host then build all hosts
    if [[ "''${hosts[@]}" =~ "$host" ]]; then
        buildHost $host
    elif [ "$host" == "all" ] ; then
        for hostname in "''${hosts[@]}"
        do
            buildHost $hostname
        done
    else
        echo "invalid hostname: $host"
        exit 1
    fi
  ''
