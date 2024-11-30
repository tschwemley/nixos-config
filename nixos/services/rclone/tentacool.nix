{config, ...}: {
  fileSystems."/mnt/tentacool" = {
    device = "tentacool:/storage";
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
# {
#   config,
#   pkgs,
#   ...
# }: let
#   hostMountPath = "flareon:/storage";
#   localMountPath = "/mnt/flareon";
# in {
#   systemd.user.services.flareon-mount = {
#     Unit = {
#       Description = "Example programmatic mount configuration with nix and home-manager.";
#       After = ["network-online.target"];
#     };
#     Service = {
#       Type = "notify";
#       ExecStartPre = "mkdir -p ${localMountPath}";
#       ExecStart = "${pkgs.rclone}/bin/rclone --config=${config.sops.secrets."rclone.conf".path} --vfs-cache-mode writes --ignore-checksum mount ${hostMountPath} ${localMountPath}";
#       ExecStop = "/bin/fusermount -u ${localMountPath}";
#     };
#     Install.WantedBy = ["default.target"];
#   };
# }
