{
  config,
  pkgs,
  utils,
  ...
}: let
  hostName = config.networking.hostName;
  ip = "${hostName}";
  bindIP = "127.0.0.1";
  port = "9336";
  grpcPort = "9337";
in {
  sops.secrets."filer.toml" = {
    sopsFile = ./secrets.yaml;
    path = "/storage/seaweedfs/${hostName}/filer.toml";
  };

  systemd.services.seaweedfs-filer = {
    after = [
      "network.target"
      "storage.mount"
    ];
    description = "SeaweedFS Filer";
    wantedBy = [
      "multi-user.target"
    ];
    environment = {};
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";
      ExecStart = utils.escapeSystemdExecArgs [
        "${pkgs.seaweedfs}/bin/weed"
        "filer"
        "-dataCenter=${hostName}"
        "-ip=${ip}"
        "-ip.bind=${bindIP}"
        "-master=moltres:9333"
        "-maxMB=64"
        "-port=${port}"
        "-port.grpc=${grpcPort}"
        "-rack=${hostName}"
      ];
      WorkingDirectory = "/storage/seaweedfs/${hostName}";
      SyslogIdentifier = "seaweedfs-filer";
    };
  };
}
