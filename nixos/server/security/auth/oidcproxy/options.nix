{lib, ...}: let
  inherit (lib) mkOption types;

  protectedHostOption = {
    options = with types; {
      allowedGroups = mkOption {
        default = [];
        type = listOf str;
      };
      allowedRealmRoles = mkOption {
        default = [];
        type = listOf str;
      };
      allowedResourceAccess = mkOption {
        default = {};
        type = attrsOf (listOf str);
      };
      clientName = mkOption {
        default = "";
        type = str;
      };
      unprotectedPaths = mkOption {
        default = [];
        type = listOf str;
      };
      upstream = mkOption {type = str;};
    };
  };
in {
  options.services.oidcproxy.protectedHosts = mkOption {
    # type = with types; listOf (submodule protectedHostOption);
    type = with types; attrsOf (submodule protectedHostOption);
    default = {};
    description = "List of virtual hosts to put behind auth proxy.";
  };
}
