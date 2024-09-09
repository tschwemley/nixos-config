{ lib, ... }:
{
  config.services.postgresql = {
    enable = true;
    ensureDatabases = [
      "invidious"
    ];

    identMap = ''
      # mapName systemUser  DBUser
      user_map  root        postgres 
    '';

    authentication = lib.mkOverride 10 ''
      #type database  DBuser  auth-method optional_ident_map
      local sameuser  all     peer        map=user_map
    '';
  };
}
