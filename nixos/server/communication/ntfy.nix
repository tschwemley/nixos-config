{config, ...}: let
  socketPath = "/run/ntfy/ntfy.sock";
in {
  services = {
    nginx = {
      upstreams.ntfy.servers."unix://${socketPath}" = {};
      virtualHosts."ntfy.schwem.io".locations."/".proxyPass = "http://ntfy";
    };

    ntfy-sh = {
      enable = true;

      # REF: https://docs.ntfy.sh/config/#config-options
      settings = {
        auth-default-access = "deny-all";
        base-url = "https://ntfy.schwem.io";
        behind-proxy = true;
        listen-unix = socketPath;
      };
    };
  };

  systemd.sockets.ntfy-sh = {
    description = "Socket for ntfy-sh notification service";
    wantedBy = ["sockets.target"];
    socketConfig = {
      ListenStream = socketPath;
      SocketUser = config.services.ntfy-sh.user;
      SocketGroup = config.services.ntfy-sh.group;
      SocketMode = "0700";
    };
  };
}
