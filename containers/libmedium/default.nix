# TODO: remove this file if 1) sticking with scribe or 2) getting rid of proxy altogether
{
  config,
  pkgs,
  ...
}:
let
  port = config.portMap.libmedium;
  tomlConfig =
    pkgs.writeText "config.toml" # toml

      ''
        debug = true
        source_code = "https://git.batsense.net/realaravinth/libmedium"
        #cache = "/var/lib/libmedium"

        [server]
        # The port at which you want authentication to listen to
        # takes a number, choose from 1000-10000 if you dont know what you are doing
        port = ${port}
        #IP address. Enter 0.0.0.0 to listen on all availale addresses
        ip = "0.0.0.0"
        # enter your hostname, eg: example.com
        domain = "medium.schwem.io"
        allow_registration = true
        proxy_has_tls = false
        #workers = 2
      '';
in
{
  services.nginx.virtualHosts."medium.schwem.io" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:7000";
    };
  };

  virtualisation.oci-containers.containers.libmedium = {
    autoStart = true;
    image = "realaravinth/libmedium";
    environment = {
      PORT = port;
    };
    ports = [ "127.0.0.1:${port}:${port}" ];
    volumes = [ "${tomlConfig}:/etc/libmedium/config.toml" ];
  };
}
