let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvm;
  profile = import ../../profiles/buyvm.nix;
  containers = [
    ../../containers/keycloak
    ../../containers/searxng
  ];
  services = [
    # TODO: service declarations below here make sense to move to appropriate profile(s)
    # ../../network/tailscale.nix
    ../../services/nginx.nix
  ];
in {
  imports =
    [
      boot
      disk
      profile
      # TODO: clean up after testing
      ../../network/systemd-networkd.nix
    ]
    ++ containers
    ++ services;

  # TODO: move this out after testing
  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"];
    externalInterface = "ens3";
    # Lazy IPv6 connectivity for the container
    enableIPv6 = true;
  };

  networking.hostName = "articuno";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
