{
  config,
  lib,
  pkgs,
  ...
}: let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvm;
  services = [
    ../../network
    ../../network/wireguard.nix
    ../../services/caddy
    ../../services/syncthing.nix
  ];
  profile = import ../../profiles/server.nix;
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ services;

  services.resolved.extraConfig = "DNS=1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";

    # secrets = {
    #   systemd_networkd_10_ens3 = {
    #     mode = "0444";
    #     path = "/etc/systemd/network/10-ens3.network";
    #     restartUnits = ["systemd-networkd" "systemd-resolved"];
    #   };
    # };
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
