mkRcloneFSOptions:
let
  host = "zapdos";
  paths = [ "var/lib/tiddlywiki/tiddlers" ];
in
{
  fileSystems = mkRcloneFSOptions host paths;
  sops.secrets.rclone_zapdos_key = {
    key = "user_ssh_key";
    mode = "0600";
    sopsFile = ../../hosts/zapdos/secrets.yaml;
  };
}
