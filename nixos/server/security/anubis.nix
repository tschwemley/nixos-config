{ self, ... }:
let
  address = "127.0.0.1";
in
{
  services.anubis = {
    enable = true;
    instances = {
      redlib = {
        settings = {
          TARGET = "http://${address}:${self.lib.port-map.redlib}";
        };
      };
    };
  };
}
