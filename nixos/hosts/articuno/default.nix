{pkgs, ...}: let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvm;
  services = [
    ../../network/wireguard.nix
    ../../network/netbird.nix
    ../../services/caddy
  ];
  profile = import ../../profiles/buyvm.nix;
in {
  imports =
    [
      boot
      disk
      profile
      # ../../services/k3s/postgresql.nix
    ]
    ++ services;

  environment.systemPackages = with pkgs; [k9s];
  networking.hostName = "articuno";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
