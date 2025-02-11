mkRcloneFSOptions: let
  host = "flareon";
  paths = [
    "storage"
    "storage2"
    "storage3"
  ];
in {
  fileSystems = mkRcloneFSOptions host paths;
  sops.secrets.rclone_flareon_key = {
    key = "user_ssh_key";
    mode = "0600";
    sopsFile = ../../hosts/flareon/secrets.yaml;
  };
}
