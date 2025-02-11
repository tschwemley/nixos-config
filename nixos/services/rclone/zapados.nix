mkRcloneFSOptions: let
  host = "zapados";
  paths = ["var/lib/tiddlywiki/tiddlers"];
in {
  fileSystems = mkRcloneFSOptions host paths;
  sops.secrets.rclone_zapados_key = {
    key = "user_ssh_key";
    mode = "0600";
    sopsFile = ../../hosts/zapados/secrets.yaml;
  };
}
