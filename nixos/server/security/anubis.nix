{ self, ... }:
let
  address = "127.0.0.1";
in
{
  services.anubis = {
    instances = {
      redlib = {
        settings = {
          TARGET = "http://${address}:${self.lib.port-map.redlib}";
        };
      };
    };
  };
}
