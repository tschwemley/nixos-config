{
  pkgs,
  secretsPath,
  ...
}: {
  environment.systemPackages = [pkgs.rclone];
  sops.secrets."rclone.conf" = {
    owner = "root";
    group = "users";

    mode = "0774";
    path = "/etc/rclone/rclone.conf";
    sopsFile = "${secretsPath}/nixos/rclone.yaml";
  };
}
