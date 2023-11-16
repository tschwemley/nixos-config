# {...}: {
{
  services.keycloak = {
    enable = true;
    settings = {
      # see: https://www.keycloak.org/server/all-config for config values
      hostName = "auth.schwem.io";
    };
  };
}
