mkRcloneFSOptions: let
  host = "jolteon";
  paths = ["storage"];
in {
  fileSystems = mkRcloneFSOptions host paths;
  sops.secrets.rclone_jolteon_key = {
    key = "user_ssh_key";
    mode = "0600";
    sopsFile = ../../hosts/jolteon/secrets.yaml;
  };
}
