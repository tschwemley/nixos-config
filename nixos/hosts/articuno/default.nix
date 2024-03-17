let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvm;
  profile = import ../../profiles/buyvm.nix;
  server = [
    ../../containers/keycloak
    ../../containers/redlib
    ../../containers/searxng
    ../../server/acme
    ../../server/cockroachdb
    ../../server/haproxy
    ../../server/monitoring
    ../../server/nginx
    ../../server/oauth2-proxy
  ];
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ server;

  networking.hostName = "articuno";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
