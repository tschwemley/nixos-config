let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvm;
  profile = import ../../profiles/buyvm.nix;
  server = [
    # ../../containers/cockroachdb
    ../../containers/keycloak
    ../../containers/redlib
    ../../containers/searxng
    ../../server/acme
    ../../server/cockroachdb
    ../../server/haproxy
    ../../server/mysql.nix
    ../../server/nginx.nix
  ];
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ server;

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
