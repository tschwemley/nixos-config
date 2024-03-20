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
  port = "9334";
  grpcPort = "9335";

  dataCenter =
    if builtins.elem hostName []
    then "lake"
    else hostName;
in {
  # include the network here since a volume will be on all servers running a filer or master in my
  # configuration
  imports = [
    ../../network/seaweedfs.nix
    ../../server/nginx/vhosts/seaweedfs.nix
  ];

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
        "-dataCenter=${dataCenter}"
        "-dir=/storage/seaweedfs/${hostName}"
        "-ip=${ip}"
        "-ip.bind=${bindIP}"
        "-max=75" # gets us to 600GB of a 1TB block
        "-mserver=${master}"
        "-port=${port}"
        "-port.grpc=${grpcPort}"
        "-publicUrl=files.schwem.io/${hostName}"
        "-rack=${hostName}"
      ];

      WorkingDirectory = "/var/lib/seaweedfs";
      SyslogIdentifier = "seaweedfs-volume";
    };
  };
}
