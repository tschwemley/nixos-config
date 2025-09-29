{ self, ... }:
let
  address = "127.0.0.1";
in
{
  services.anubis = {
    instances = {
      redlib = {
        settings = {
          BIND = ":${self.lib.port-map.anubis}";
          BIND_NETWORK = "tcp";
          TARGET = "http://${address}:${self.lib.port-map.redlib}";
        };
      };
    };
  };
}
