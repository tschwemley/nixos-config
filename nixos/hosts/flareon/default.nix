{
  imports = [
    ../../profiles/proxmox.nix
    ../../services/samba.nix
  ];

  networking.hostName = "flareon";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}


/*
{lib, ...}: let
  boot = (import ../../system/boot.nix).systemd;
  profile = import ../../profiles/proxmox.nix;
  server = [
    ../../services/samba.nix
  ];
in {
  imports =
    [
      boot
      profile
    ]
    ++ server;

  networking.hostName = "flareon";
  services.resolved.dnsovertls = lib.mkDefault "true";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
*/
