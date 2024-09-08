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
    invidious = "3100";
    it-tools = "7001";
    priviblur = "8040";
    proxitok = "8050";
    rimgo = "8030";
    safetwitch-frontend = "8280";
    safetwitch-backend = "7100";
    scribe = "7000";
    threadfin = "34400";
  };
}
