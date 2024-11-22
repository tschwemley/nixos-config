{
  pkgs,
  secretsPath,
  ...
}: {
  environment.systemPackages = with pkgs; [rclone];
  sops.secrets."rclone.conf" = {
    mode = "0754";
    path = "/etc/rclone/rclone.conf";
    sopsFile = "${secretsPath}/nixos/rclone.yaml";
  };
}
