{pkgs, ...}: let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvm;
  services = [
    # ../../network/netbird.nix
  ];
  webServices = [
    ../../services/nginx.nix
    ../../services/searxng
  ];
  profile = import ../../profiles/buyvm.nix;
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ services
    ++ webServices;

  environment.systemPackages = with pkgs; [k9s];
  networking.hostName = "articuno";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";

  # TODO: see if this is necessary
  systemd.network.wait-online.enable = false;
}
