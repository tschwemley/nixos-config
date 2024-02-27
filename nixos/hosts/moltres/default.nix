let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvmWithStorage;
  profile = import ../../profiles/buyvm.nix;
  services = [
    ../../network/netbird.nix
    # ../../services/nginx.nix
  ];
  virtualHosts = [
    # ../../virtualisation/containers/nixos/searxng/virtualhost.nix
  ];
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ services
    ++ virtualHosts;

  networking.hostName = "moltres";
  # services.resolved.extraConfig = "DNS=1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
