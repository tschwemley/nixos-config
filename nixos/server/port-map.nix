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
    forgejo = "8020";
    # libmedium = "7000";
    scribe = "7000";
  };
}
