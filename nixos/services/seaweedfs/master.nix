{
  config,
  pkgs,
  ...
}: {
  systemd.services.seaweedfs-master = {
    after = [
      "network.target"
    ];
    description = "SeaweedFS Server";
    wantedBy = [
      "multi-user.target"
    ];
    environment = {};
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";
      ExecStart = "${pkgs.seaweedfs}/bin/weed master -ip=${config}";
      WorkingDirectory = "/var/lib/seaweedfs";
      SyslogIdentifier = "seaweedfs-master";
    };
  };
}
