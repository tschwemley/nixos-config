{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf stringList;
in {
  options = {
    services.rclone = {
      enableFlareon = mkEnableOption "flareon";
      enableJolteon = mkEnableOption "jolteon";
      enableTentacool = mkEnableOption "tentacool";

      options = mkOption {
        type = stringList;
        default = [
          "allow_other"
          "args2env"
          "config=${config.sops.secrets."rclone.conf".path}"
          "metadata"
          # "nodev"
          "nofail"
          "vfs-cache-mode=writes"
        ];
      };
    };
  };
}
