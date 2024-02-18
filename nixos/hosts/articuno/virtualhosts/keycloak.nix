{...}: let
  # TODO: get this in a smarter way
  ip = "10.10.1.2";
  port = "80";
in {
  services.nginx.virtualHosts."auth.schwem.io" = {
    forceSSL = true;
    enableACME = true;
    locations =
      map (path: {
        ${path} = {
          proxyPass = "http://${ip}:${port}/${path}";
        };
      }) [
        "js"
        "realms"
        "resources"
        "robots.txt"
      ];
    # locations."/" = {
    #   proxyPass = "http://${ip}:80/";
    # };
  };
}
