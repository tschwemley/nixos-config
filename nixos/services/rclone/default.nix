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

  # TODO: create rclone user that is only able to access explicitly defined directories
  #
  # services.openssh.settings.Match = [
  #   {
  #     # This is the critical section for the user restriction
  #     User = "rclone_user";
  #     ChrootDirectory = "/var/chroot/rclone_user";
  #     ForceCommand = "internal-sftp";
  #     AllowTcpForwarding = "no";
  #     PermitTTY = "no";
  #     X11Forwarding = "no";
  #   }
  # ];
  #
  # systemd.tmpfiles.rules = [
  #   "d /var/chroot/rclone/ 0770 rclone rclone -"
  # ];
  #
  # users.groups.rclone
}
