{lib, ...}: let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvmWithStorage;
  profile = import ../../profiles/buyvm.nix;
  server = [
    ../../services/seaweedfs/filer.nix
    ../../services/seaweedfs/volume.nix
  ];
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ server;

  networking.hostName = "eevee";

  # TODO: change this on all servers
  services.getty.autologinUser = "root";

  # eevee uses a private instance of nginx
  services.nginx.enable = lib.mkDefault false;

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
