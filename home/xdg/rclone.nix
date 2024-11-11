# TODO: probably not the right spot for this to live
{
  config,
  secretsPath,
  ...
}: {
  sops.secrets."rclone.conf" = {
    path = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
    sopsFile = "${secretsPath}/home/rclone.yaml";
  };
}
