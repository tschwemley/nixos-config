{
  pkgs,
  dir,
  ...
}: {
  systemd.services.seaweedfs-volume = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 30";

      ExecStart = "${pkgs.seaweedfs}/bin/weed volume -dir=${dir}";
      WorkingDirectory = "/var/lib/seaweedfs";
      StateDirectory = "seaweedfs";
      SyslogIdentifier = "seaweedfs-volume";
    };

    description = "SeaweedFS Server";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
  };
}
