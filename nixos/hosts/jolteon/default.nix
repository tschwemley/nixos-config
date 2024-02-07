{
  config,
  lib,
  pkgs,
  ...
}: let
  boot = (import ../../system/boot.nix).systemd;
  disk = (import ../../hardware/disks).proxmox;
  profile = import ../../profiles/server.nix;
  services = [
    ../../network/wireguard.nix
    ../../services/netmaker
    ../../services/caddy
    ../../services/syncthing.nix
  ];
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ services;

  networking = {
    hostName = "jolteon";
    useDHCP = lib.mkDefault true;
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # don't update this
  system.stateVersion = "23.05";
}
