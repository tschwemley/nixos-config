{
  services.nginx.virtualHosts = {
    "git.srht.schwem.io".sslCertificate = "/var/lib/acme/srht.schwem.io-wildcard";
  };
  services.sourcehut = {
    enable = true;
    git.enable = true;
    hub.enable = true;
    man.enable = true;
    nginx.enable = true;
    pages.enable = true;
    paste.enable = true;
    todo.enable = true;

    settings = {
      "sr.ht" = {
        global-domain = "srht.schwem.io";
      };
    };
  };
}
