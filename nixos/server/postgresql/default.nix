{ lib, ... }:
{
  services.postgresql = {
    enable = true;

    identMap = ''
      # mapName systemUser  DBUser
      user_map  root        postgres 
      user_map  postgres    postgres 
      user_map  keycloak    keycloak 
    '';

    authentication = lib.mkOverride 10 ''
      #type database  DBuser    auth-method optional_ident_map
      local sameuser  all       peer        map=user_map
    '';
  };
}
