{config, ...}: {
  fileSystems."/mnt/jolteon" = {
    device = "jolteon:/storage";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "config=${config.sops.secrets."rclone.conf".path}"
    ];
  };
}
