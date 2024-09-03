{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.scribe.nixosModules.default
  ];

  services.nginx.virtualHosts."medium.schwem.io" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${config.port-map.scribe}";
    };
  };

  services.scribe = {
    enable = true;
    appDomain = "medium.schwem.io";
    port = config.port-map.scribe;
    environmentFile = config.sops.secrets.scribe-env.path;
  };

  sops.secrets.scribe-env.sopsFile = ./secrets.yaml;
}
