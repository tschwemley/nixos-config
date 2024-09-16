{
  config,
  pkgs,
  utils,
  ...
}:
let
  ip = "${config.networking.hostName}.wyvern-map.ts.net";
in
# bindIP = "127.0.0.1";
# bindIP = ip;
{
  systemd.services.seaweedfs-master = {
    after = [
      "network.target"
    ];
    description = "SeaweedFS Server";
    wantedBy = [
      "multi-user.target"
    ];
    environment = { };
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";
      ExecStart = utils.escapeSystemdExecArgs [
        "${pkgs.seaweedfs}/bin/weed"
        "master"
        "-ip=${ip}"
        "-ip.bind=${ip}"
        "-mdir=master"
        "-volumePreallocate"
        "-volumeSizeLimitMB=8192"
      ];
      WorkingDirectory = "/var/lib/seaweedfs";
      SyslogIdentifier = "seaweedfs-master";
    };
  };
}
