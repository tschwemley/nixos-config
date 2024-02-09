let
  boot = (import ../../system/boot.nix).systemd;
  disk = (import ../../hardware/disks).proxmox;
  profile = import ../../profiles/server.nix;
  services = [
    ../../network
    ../../network/wireguard.nix
  ];
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ services;

  networking.hostName = "zapados";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
