{...}: let
  ip = "10.10.1.2";
  port = "80";
in {
  services.nginx.virtualHosts."auth.schwem.io" = {
    forceSSL = true;
    enableACME = true;
    locations = {
      "/admin" = {
        proxyPass = "http://${ip}:${port}/admin";
      };
      "/js" = {
        proxyPass = "http://${ip}:${port}/js";
      };
      "/realms" = {
        proxyPass = "http://${ip}:${port}/realms";
      };
      "/resources" = {
        proxyPass = "http://${ip}:${port}/resources";
      };
      "/robots.txt" = {
        proxyPass = "http://${ip}:${port}/robots.txt";
      };
    };
  };
}
