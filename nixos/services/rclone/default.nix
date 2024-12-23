{
  config,
  lib,
  pkgs,
  secretsPath,
  ...
}: let
  cfg = config.services.rclone;

  inherit (lib) mkEnableOption mkIf;

  fileSystems = (lib.lists.foldr (name: fs:
    fs
    // {
      "/mnt/${name}" =
        mkIf (
          (name == "tentacool" && cfg.enableTentacool)
          || (name == "jolteon" && cfg.enableJolteon)
          || (name == "flareon" && cfg.enableFlareon)
        ) {
          device = "${name}:/storage";
          fsType = "rclone";
          options = [
            "nodev"
            "nofail"
            "allow_other"
            "args2env"
            "vfs-cache-mode=writes"
            "config=${config.sops.secrets."rclone.conf".path}"
            "metadata"
          ];
        };
    }) {}) ["flareon" "jolteon" "tentacool"];
in {
  options = {
    services.rclone = {
      enableFlareon = mkEnableOption "flareon";
      enableJolteon = mkEnableOption "jolteon";
      enableTentacool = mkEnableOption "tentacool";
    };
  };

  config = {
    inherit fileSystems;

    environment.systemPackages = [pkgs.rclone];

    sops.secrets."rclone.conf" = {
      owner = "root";
      group = "users";

      mode = "0774";
      path = "/etc/rclone/rclone.conf";
      sopsFile = "${secretsPath}/nixos/rclone.yaml";
    };
  };
}
