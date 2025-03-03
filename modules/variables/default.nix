{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.variables = {
    ports = mkOption {
      type = types.attrsOf types.str;
      default = {};
    };
  };

  config.variables.ports = import ./port-map.nix;
}
