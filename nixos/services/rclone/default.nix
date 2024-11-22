{
  pkgs,
  secretsPath,
  ...
}: {
  environment.systemPackages = with pkgs; [rclone];
  sops.secrets."rclone.conf" = {
    sopsFile = "${secretsPath}/nixos/rclone.yaml";
  };
}
