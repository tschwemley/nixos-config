{config, ...}: let
  inherit (config.services.ntfy-sh) group user;

  socketPath = "/run/ntfy/ntfy.sock";
in {
  services = {
    nginx = {
      upstreams.ntfy.servers."unix:${socketPath}" = {};
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

  systemd = {
    sockets.ntfy-sh = {
      description = "Socket for ntfy-sh notification service";
      wantedBy = ["sockets.target"];
      socketConfig = {
        ListenStream = socketPath;
        RemoveOnStop = true;
        SocketUser = user;
        SocketGroup = group;
        SocketMode = "0760";
      };
    };

    tmpfiles.rules = ["d /run/ntfy 0750 ${user} ${group} -"];
  };

  users.groups.ntfy-sh.members = ["nginx"];
}
