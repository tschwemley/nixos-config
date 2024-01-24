{
  config,
  pkgs,
  ...
}: {
  systemd.services.seaweedfs-master = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";

      ExecStart = "${pkgs.seaweedfs}/bin/weed master -ip=${config.nodeIP}";
      WorkingDirectory = "/var/lib/seaweedfs";
      StateDirectory = "seaweedfs";
      SyslogIdentifier = "seaweedfs-master";
    };

    unitConfig = {
      After = "network.target";
      Description = "SeaweedFS Server";
    };

    wantedBy = ["multi-user.target"];
  };
}
