{ lib, ... }:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "invidious"
    ];

    identMap = ''
      # mapName systemUser  DBUser
      user_map  root        postgres 
      user_map  postgres    postgres 
    '';

    authentication = lib.mkOverride 10 ''
      #type database  DBuser    auth-method optional_ident_map
      local all       postgres  peer
      local sameuser  all       peer        map=user_map
    '';
  };
}
