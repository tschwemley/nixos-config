let
  storageDisks = [
    (import ../../hardware/disks/block-storage.nix {
      device = "/dev/disk/by-id/scsi-0BUYVM_SLAB_VOLUME-28656";
    })
    (import ../../hardware/disks/block-storage.nix {
      device = "/dev/disk/by-id/scsi-0BUYVM_SLAB_VOLUME-28639";
      mountpoint = "storage2";
    })
  ];
in {
  imports =
    [
      ../../profiles/buyvm.nix

      # server imports
      ../../server/communication/ntfy.nix
      ../../server/dashboard
      ../../server/development/cyberchef.nix
      ../../server/infrastructure/haproxy
      ../../server/infrastructure/monitoring
      ../../server/infrastructure/postgresql
      ../../server/security/acme
      ../../server/security/auth/keycloak
      ../../server/services/searxng
    ]
    ++ storageDisks;

  networking.hostName = "articuno";
  services.tailscale.extraUpFlags = ["--advertise-tags=tags:server,tags:master"];
  sops.defaultSopsFile = ./secrets.yaml;
  system.stateVersion = "23.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
