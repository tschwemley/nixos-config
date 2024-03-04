{...}: {
  perSystem = {
    self',
    config,
    lib,
    options,
    pkgs,
    ...
  }: {
    packages = with pkgs; {
      build-host = writeScriptBin "build-host" ''
        #!/usr/bin/env sh
        HOST=$1

        if [ $HOST = "servers" ] ; then
          ${./scripts/build-servers.sh}
        else
          nix build .#nixosConfigurations.$HOST.config.system.build.toplevel -o $HOST
          nix-copy-closure --to $HOST $HOST
          rm $HOST
        fi
      '';
      prefetch-url-sha256 = writeScriptBin "prefetch-url-sha256" ''
        hash=$(nix-prefetch-url "$1")
        nix hash to-sri --type sha256 $hash
      '';
    };
  };
}
