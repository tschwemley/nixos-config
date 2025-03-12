lib: let
  buildHosts = lib.mapAttrs' (
    host: _: {
      name = "build-${host}";
      value = "nix build .#nixosConfigurations.${host}.config.system.build.toplevel";
    }
  ) (builtins.readDir ../../../../nixos/hosts);
in
  {
    cdnix = "cd ~/nixos-config";
    hms = "nix run home-manager/master -- switch --flake ";
    nfc = "nix flake check";
    nfu = "nix flake update && git add flake.lock && git commit -m 'flake update' && git push origin main";
    # ngc = "sudo nix-collect-garbage --delete-older-than 3d && sudo nix-store --gc --delete-older-than 3d";
    ngc = "sudo nix-collect-garbage && sudo nix-store --gc --delete-older-than 3d";
    nixconf = "cd ~/nixos-config";
    nrbs = "sudo nixos-rebuild switch --flake .#$HOST";
    systemd2nix = "nix run github:DavHau/systemd2nix";
  }
  // buildHosts
