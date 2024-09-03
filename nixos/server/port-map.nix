{lib, ...}: {
  options.portMap = with lib;
    mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = "Map of server app/service name to port(s) used. Used to avoid collisions.";
    };

  config.portMap = {
    anonymous-overflow = "8010";
    libmedium = "7000";
  };
}
