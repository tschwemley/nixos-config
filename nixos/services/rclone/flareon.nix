{config, ...}: {
  fileSystems."/mnt/flareon" = {
    device = "flareon:/storage";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "vfs-cache-mode=writes"
      "config=${config.sops.secrets."rclone.conf".path}"
    ];
  };

  sops.secrets.rclone_flareon_key = {
    key = "user_ssh_key";
    mode = "0600";
    sopsFile = ../../hosts/flareon/secrets.yaml;
  };
}
