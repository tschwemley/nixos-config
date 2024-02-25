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
      haxe-language-server = buildNpmPackage {
        pname = "haxe-language-server";
        version = "0.0";
        src = fetchFromGitHub {
          owner = "vshaxe";
          repo = "haxe-language-server";
          rev = "master";
          hash = "sha256-7wF4y+jL9cp7sTolV40lzW8swuXjHUzcSaXTH7Xatd4=";
        };

        npmDepsHash = "sha256-P0gIO5xmAvHfQftiPHxayhNuyFhlSBAfVGLfKUcFnok=";
      };
    };
  };
}
