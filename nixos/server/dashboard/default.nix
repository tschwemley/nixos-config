{
  services.nginx.virtualHosts."schwem.io".locations = {
    "/" = {
      proxyPass = "http://localhost:6969";
      extraConfig = ''
        auth_request .auth;
      '';
    };

    ".auth".proxyPass = "http://localhost:1337/auth";
  };
}
