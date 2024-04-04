{
  services.nginx.virtualHosts = let
    sslCertificate = "/var/lib/acme/srht.schwem.io-wildcard/cert.pem";
    sslCertificateKey = "/var/lib/acme/srht.schwem.io-wildcard/key.pem";
  in {
    "git.srht.schwem.io" = {inherit sslCertificate sslCertificateKey;};
    "hub.srht.schwem.io" = {inherit sslCertificate sslCertificateKey;};
    "man.srht.schwem.io" = {inherit sslCertificate sslCertificateKey;};
    "pages.srht.schwem.io" = {inherit sslCertificate sslCertificateKey;};
    "paste.srht.schwem.io" = {inherit sslCertificate sslCertificateKey;};
    "todo.srht.schwem.io" = {inherit sslCertificate sslCertificateKey;};
  };

  services.sourcehut = {
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
