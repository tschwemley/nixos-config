{
  config,
  pkgs,
  ...
}: let
  mkSeaweedService = type: {
    systemd.services."seaweedfs-${type}" = {
      enable = true;
      serviceConfig = {
        Type = "simple";
        User = "root";
        Group = "root";

        ExecStart = "${pkgs.seaweedfs}/bin/weed ${type} -ip=${config.nodeIP}";
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
  };
in {
  master = mkSeaweedService "master";
}
