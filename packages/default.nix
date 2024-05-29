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
    };
  };
}
