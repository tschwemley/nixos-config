{...}: {
  perSystem = {
    self',
    config,
    lib,
    options,
    pkgs,
    ...
  }: let
    hyprlandPlugins = import ./hyprlandPlugins pkgs;
    vimPlugins = import ./vimPlugins pkgs;
  in {
    packages = with pkgs; {
      inherit (hyprlandPlugins) hypreasymotion hyprscroller;
      inherit (vimPlugins) codecompanion harpoon neogit-nightly;

      bambu-studio = import ./bambu-studio.nix;
      # bambu-studio = pkgs.bambu-studio.overrideAttrs rec {
      #   version = "1.09.03.50";
      #   src = fetchFromGitHub {
      #     owner = "bambulab";
      #     repo = "BambuStudio";
      #     rev = "v${version}";
      #     hash = "sha256-RBctBhKo7mjxsP7OJhGfoU1eIiGVuMiAqwwSU+gsMds=";
      #   };
      # };

      build-all-hosts = writeScriptBin "build-all-hosts" ''
        #!/usr/bin/env sh
        build-host articuno && build-host zapados && build-host moltres && build-host eevee \
          && build-host flareon && build-host jolteon
      '';
      build-installer-iso = writeScriptBin "build-installer-iso" "${pkgs.nixos-generators}/bin/nixos-generate -f install-iso";
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
      systemd2nix = writeScriptBin "systemd2nix" ''
        nix run github:DavHau/systemd2nix < $1
      '';
      redlib = pkgs.stdenv.mkDerivation {
        name = "redlib";

        src = fetchurl {
          url = "https://github.com/redlib-org/redlib/releases/download/v0.34.0/redlib";
          hash = "sha256-7YNTC37OQRanBIIdRJXw1Jq+R+0y3awVcOF7EZ9bjCE=";
        };

        dontUnpack = true;
        dontBuild = true;

        installPhase = ''
          # mkdir -p $out/bin
          # cp $src/redlib $out/bin/redlib
          cp $src $out
          chmod +x $out
        '';
      };
      wl-ocr = pkgs.callPackage ./wl-ocr {};
    };
  };
}
