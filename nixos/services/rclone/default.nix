{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.rclone;

  options = [
    "allow_other"
    "args2env"
    "config=${config.sops.secrets."rclone.conf".path}"
    "metadata"
    "nodev"
    "nofail"
    "vfs-cache-mode=writes"
  ];
  fsType = "rclone";

  mkRcloneFSOptions =
    host: paths:
    lib.listToAttrs (
      map (
        path:
        lib.nameValuePair "/mnt/${host}/${path}" {
          inherit fsType options;
          depends = [ "/home" ];
          device = "${host}:/${path}";
        }
      ) paths
    );
in
{
  imports = [
    ./options.nix
    # (lib.mkIf cfg.enableArticuno (import ./articuno.nix mkRcloneFSOptions))
    (lib.mkIf cfg.enableJolteon (import ./jolteon.nix mkRcloneFSOptions))
    (lib.mkIf cfg.enableFlareon (import ./flareon.nix mkRcloneFSOptions))
    (lib.mkIf cfg.enableTentacool (import ./tentacool.nix mkRcloneFSOptions))
    # (lib.mkIf cfg.enablezapdos (import ./zapdos.nix mkRcloneFSOptions))
  ];

  environment.systemPackages = [ pkgs.rclone ];

  sops.secrets."rclone.conf" = {
    owner = "root";
    group = "users";

    mode = "0744";
    path = "/etc/rclone/rclone.conf";
    sopsFile = "${self.lib.secrets.nixos}/rclone.yaml";
  };
}
