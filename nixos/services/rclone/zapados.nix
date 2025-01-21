{config, ...}: {
  fileSystems."/home/schwem/tiddlywiki" = {
    device = "zapados:/var/lib/tiddlywiki/tiddlers";
    fsType = "rclone";
    options = [
      "allow-other"
      "args2env"
      "config=${config.sops.secrets."rclone.conf".path}"
      "metadata"
      "nofail"
      "vfs-cache-mode=writes"
    ];
  };

  sops.secrets.rclone_zapados_key = {
    key = "user_ssh_key";
    mode = "0600";
    sopsFile = ../../hosts/zapados/secrets.yaml;
  };
}
