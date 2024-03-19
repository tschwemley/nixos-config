{pkgs, ...}: {
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
      ExecStartPre = "/bin/sleep 30";
      ExecStart = "${pkgs.seaweedfs}/bin/weed filer";
      WorkingDirectory = "/storage";
      SyslogIdentifier = "seaweedfs-filer";
    };
  };
}
