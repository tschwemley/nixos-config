{
  config,
  pkgs,
  utils,
  ...
}: let
  hostName = config.networking.hostName;

  bindIP = "127.0.0.1";
  ip = "${hostName}.wyvern-map.ts.net";
  master = "moltres.wyvern-map.ts.net:9333";
  port = "9334";
  grpcPort = "9335";
in {
  systemd.services.seaweedfs-volume = {
    after = [
      "network.target"
      "storage.mount"
    ];
    description = "SeaweedFS Volume";
    wantedBy = [
      "multi-user.target"
    ];
    environment = {};
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";

      # ExecStartPre = "${pkgs.coreutils}/bin/sleep 30";

      ExecStart = utils.escapeSystemdExecArgs [
        "${pkgs.seaweedfs}/bin/weed"
        "volume"
        "-dataCenter=${hostName}"
        "-dir=/storage/seaweedfs/${hostName}"
        "-ip=${ip}"
        "-ip.bind=${bindIP}"
        "-max=75" # gets us to 600GB of a 1TB block
        "-mserver=${master}"
        "-port=${port}"
        "-port.grpc=${grpcPort}"
        "-rack=${hostName}"
      ];

      WorkingDirectory = "/var/lib/seaweedfs";
      SyslogIdentifier = "seaweedfs-volume";
    };
  };
}
