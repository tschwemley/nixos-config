{
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.rclone;

  inherit (lib) mkEnableOption mkIf;

  # FIXME: this is dogshit
  fileSystems =
    ((lib.lists.foldr (name: fs:
      fs
      // {
        "/mnt/${name}" =
          mkIf (
            (name == "flareon" && cfg.enableFlareon)
            || (name == "jolteon" && cfg.enableJolteon)
            || (name == "tentacool" && cfg.enableTentacool)
            || (name == "zapados" && cfg.enableZapados)
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
      }) {}) ["flareon" "jolteon" "tentacool" "zapados"])
    // {};

  tmpFileRules = let
    mkRule = name: "d /mnt/${name} 0775 root root - -";
  in
    (
      if cfg.enableFlareon
      then [(mkRule "flareon")]
      else []
    )
    ++ (
      if cfg.enableJolteon
      then [(mkRule "jolteon")]
      else []
    )
    ++ (
      if cfg.enableTentacool
      then [(mkRule "tentacool")]
      else []
    )
    ++ (
      if cfg.enableZapados
      then [(mkRule "zapados")]
      else []
    );
in {
  options = {
    services.rclone = {
      enableFlareon = mkEnableOption "flareon";
      enableJolteon = mkEnableOption "jolteon";
      enableTentacool = mkEnableOption "tentacool";
      enableZapados = mkEnableOption "zazpados";
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
      sopsFile = "${self.lib.secrets.nixos}/rclone.yaml";
    };

    systemd.tmpfiles.rules = tmpFileRules;
  };
}
