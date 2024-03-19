{
  dataCenter,
  rack,
  config,
  pkgs,
  utils,
  ...
}: let
  ip = "${config.networking.hostName}";
  bindIP = "127.0.0.1";
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
      ExecStartPre = "sleep 30";

      ExecStart = utils.escapeSystemdExecArgs [
        "${pkgs.seaweedfs}/bin/weed"
        "volume"
        "-dataCenter=${dataCenter}"
        "-dir=/storage/seaweedfs/${config.networking.hostName}"
        "-ip=${ip}"
        "-ip.bind=${bindIP}"
        "-max=75" # gets us to 600GB of a 1TB block
        "-mserver=moltres:9333"
        "-port=${port}"
        "-port.grpc=${grpcPort}"
        "-rack=${rack}"
      ];

      WorkingDirectory = "/var/lib/seaweedfs";
      SyslogIdentifier = "seaweedfs-volume";
    };
  };
}
