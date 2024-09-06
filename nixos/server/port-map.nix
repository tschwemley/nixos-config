{ lib, ... }:
{
  options.portMap =
    with lib;
    mkOption {
      type = types.attrsOf types.str;
      default = { };
      description = "Map of server app/service name to port(s) used. Used to avoid collisions.";
    };

  config.portMap = {
    anonymous-overflow = "8010";
    binternet = "8009";
    freetar = "22000";
    forgejo = "8020";
    it-tools = "7001";
    rimgo = "8030";
    # libmedium = "7000";
    scribe = "7000";
  };
}
