let
  address = "127.0.0.1";
  port = 8180;
in {
  imports = [./virtualhost.nix];

  services.redlib = {
    inherit address port;
    enable = true;
    openFirewall = true;
  };


  # systemd.services.redlib = {
  #   after = [
  #     "network.service"
  #   ];
  #   description = "redlib daemon";
  #   wantedBy = [
  #     "default.target"
  #   ];
  #   environment = {
  #     REDLIB_DEFAULT_THEME = "gruvboxdark";
  #     REDLIB_DEFAULT_SHOW_NSFW = "on";
  #     REDLIB_DEFAULT_USE_HLS = "on";
  #     REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION = "on";
  #     # see: https://github.com/redlib-org/redlib?tab=readme-ov-file#configuration
  #   };
  #   serviceConfig = {
  #     DynamicUser = "yes";
  #     EnvironmentFile = "/etc/redlib.conf";
  #     ExecStart = "${pkgs.redlib} -a ${listenAddress} -p ${port}";
  #     DeviceAllow = "";
  #     LockPersonality = "yes";
  #     MemoryDenyWriteExecute = "yes";
  #     PrivateDevices = "yes";
  #     ProcSubset = "pid";
  #     ProtectClock = "yes";
  #     ProtectControlGroups = "yes";
  #     ProtectHome = "yes";
  #     ProtectHostname = "yes";
  #     ProtectKernelLogs = "yes";
  #     ProtectKernelModules = "yes";
  #     ProtectKernelTunables = "yes";
  #     ProtectProc = "invisible";
  #     RestrictAddressFamilies = "AF_INET AF_INET6";
  #     RestrictNamespaces = "yes";
  #     RestrictRealtime = "yes";
  #     RestrictSUIDSGID = "yes";
  #     SystemCallArchitectures = "native";
  #     SystemCallFilter = "@system-service ~@privileged ~@resources";
  #     UMask = "0077";
  #   };
  # };
}
