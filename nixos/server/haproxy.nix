let
  baseCert = "/var/lib/acme/schwem.io/full.pem";
  wildcardCert = "/var/lib/acme/schwem.io-wildcard/full.pem";
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
        server articuno articuno:8080 send-proxy-v2
        server moltres moltres:8080 send-proxy-v2
    '';
  };

  users.users.haproxy.extraGroups = ["acme"];
}
