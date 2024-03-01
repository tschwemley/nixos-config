let
  baseCert = /var/lib/acme/schwem.io/cert.pem;
  wildcardCert = /var/lib/acme/schwem.io.wildcard/cert.pem;
in {
  services.haproxy = {
    enable = true;
    config = ''
      frontend https-in
        bind *:80
        bind *:443 ssl crt ${baseCert} crt ${wildcardCert}
        http-request redirect scheme https unless { ssl_fc }
        default_backend servers

      backend servers
        mode http
        server articuno articuno:8080
        server moltres moltres:8080
    '';
  };
}
