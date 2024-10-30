{ lib, ... }:
let
  inherit (lib) mkOption types;

  protectedHostOption = {
    options = {
      host = mkOption { type = types.str; };
      redirect = mkOption { type = types.str; };
    };
  };
in
{
  options.services.oidcsso.protectedHosts = mkOption {
    type = with types; listOf (submodule protectedHostOption);
    default = [ ];
    description = "List of virtual hosts to put behind auth proxy.";
  };
}
