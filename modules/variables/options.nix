{lib, ...}: let
  inherit (lib) mkOption types;
  inherit (types) attrsOf path str;
in {
  options.variables = {
    ports = mkOption {
      type = attrsOf str;
      default = {};
    };

    secretPaths = mkOption {
      type = attrsOf path;
      default = {
        home = ../../secrets/home;
        nixos = ../../secrets/nixos;
        server = ../../secrets/server;
      };
    };
  };
}
