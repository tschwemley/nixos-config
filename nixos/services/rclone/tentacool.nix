mkRcloneFSOptions: let
  host = "tentacool";
  paths = ["storage"];
in {
  fileSystems = mkRcloneFSOptions host paths;
  sops.secrets.rclone_tentacool_key = {
    key = "user_ssh_key";
    mode = "0600";
    sopsFile = ../../hosts/tentacool/secrets.yaml;
  };
}
