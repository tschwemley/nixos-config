{pkgs, ...}: {
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
      ExecStartPre = "/bin/sleep 30";
      ExecStart = "${pkgs.seaweedfs}/bin/weed volume -dir=\"/storage\"";
      WorkingDirectory = "/var/lib/seaweedfs";
      SyslogIdentifier = "seaweedfs-volume";
    };
  };
}
