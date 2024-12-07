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
}
