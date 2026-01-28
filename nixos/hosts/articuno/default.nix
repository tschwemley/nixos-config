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
in
{
  imports = [
    ../../profiles/buyvm.nix

    # server imports
    ../../server/alt-frontends/freetar.nix
    # ../../server/alt-frontends/invidious.nix
    # ../../server/alt-frontends/redlib.nix
    # ../../server/alt-frontends/safetwitch

    ../../server/communication/ntfy.nix
    ../../server/development/cyberchef.nix
    ../../server/infrastructure/haproxy
    ../../server/infrastructure/monitoring
    ../../server/infrastructure/postgresql

    ../../server/security/acme
    ../../server/security/auth/keycloak
    ../../server/services/glance.nix
  ]
  ++ storageDisks;

  networking.hostName = "articuno";
  services.tailscale.extraUpFlags = [ "--advertise-tags=tags:server,tags:master" ];
  sops.defaultSopsFile = ./secrets.yaml;
  system.stateVersion = "23.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion

  # TODO: commit this and standarize
  users.users.rclone-shared = {
    isNormalUser = true;
    home = "/storage/shared";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIitj/kzZlHZN19wNO3tSpkjuLQ3ewMhMRgvyyIWUPeH rclone shared access"
    ];
  };

  services.openssh.extraConfig = ''
    Match User rclone-shared
      ChrootDirectory /storage/shared
      ForceCommand internal-sftp
      AllowTcpForwarding no
      X11Forwarding no
  '';

  systemd.tmpfiles.rules = [
    "d /storage 755 root root -"
    "d /storage/shared 755 rclone-shared rclone-shared -"
  ];
}
