{lib, ...}: let
  inherit (lib) mkOption types;

  protectedHostOption = {
    options = with types; {
      allowedGroups = mkOption {type = listOf str;};
      allowedRealmRoles = mkOption {type = listOf str;};
      allowedResourceAccess = mkOption {type = attrsOf listOf str;};
      host = mkOption {type = str;};
      # redirect = mkOption {type = str;};
    };
  };
in {
  options.services.oidcsso.protectedHosts = mkOption {
    type = with types; listOf (submodule protectedHostOption);
    default = [];
    description = "List of virtual hosts to put behind auth proxy.";
  };
}
