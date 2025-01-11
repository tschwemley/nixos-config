{self, config, ...}: let 
  downloadDirectory = "/storage/downloads/pyload";

  inherit (config.services.pyload) group;
  owner = config.services.pyload.user;
in {
  services.pyload = {
    inherit downloadDirectory;

    enable = true;

    credentialsFile = config.sops.secrets.pyload-env.path;
  };

  sops.secrets.pyload-env = {
    inherit group owner;

    format = "dotenv";
    key = "";
    mode = "0400";
    sopsFile = "${self.lib.secrets.server}/pyload.env";
  };

  systemd.tmpfiles.rules = ["d ${downloadDirectory} 0755 ${owner} ${group} - -" ];
}
