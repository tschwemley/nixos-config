let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvmWithStorage;
  profile = import ../../profiles/buyvm.nix;
  server = [
    ../../containers/mysql
    ../../containers/searxng
    ../../server/nginx.nix
  ];
  services = [
    # TODO: service declarations below here make sense to move to appropriate profile(s)
    ../../network/tailscale.nix
  ];
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ server
    ++ services;

  networking.hostName = "moltres";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
