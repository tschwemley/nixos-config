{
  config,
  pkgs,
  utils,
  ...
}: let
  hostName = config.networking.hostName;

  # bindIP = "127.0.0.1";
  bindIP = ip;
  ip = "${hostName}.wyvern-map.ts.net";
  master = "moltres.wyvern-map.ts.net:9333";
  port = "9336";
  grpcPort = "9337";

  dataCenter =
    if builtins.elem hostName []
    then "lake"
    else hostName;
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
        "-dataCenter=${dataCenter}"
        "-ip=${ip}"
        "-ip.bind=${bindIP}"
        "-master=${master}"
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
