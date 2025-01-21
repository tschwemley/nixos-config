let
  storageDisks = [
    (import ../../hardware/disks/block-storage.nix {device = "/dev/disk/by-id/scsi-0BUYVM_SLAB_VOLUME-28656";})
    (import ../../hardware/disks/block-storage.nix {
      device = "/dev/disk/by-id/scsi-0BUYVM_SLAB_VOLUME-28639";
      mountpoint = "/storage2";
    })
  ];
in {
  imports =
    [
      (import ../../profiles/buyvm.nix "")

      # server imports
      ../../server/dashboard
      ../../server/development/cyberchef.nix
      ../../server/infrastructure/haproxy
      ../../server/infrastructure/monitoring
      ../../server/infrastructure/postgresql
      ../../server/security/acme
      ../../server/security/auth/keycloak
      ../../server/services/open-webui.nix
      ../../server/services/searxng
    ]
    ++ storageDisks;

  networking.hostName = "articuno";

  sops.defaultSopsFile = ./secrets.yaml;

  services.tailscale.extraUpFlags = ["--advertise-tags=tags:server,tags:master"];

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
