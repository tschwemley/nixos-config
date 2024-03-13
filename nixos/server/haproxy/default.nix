let
  baseCert = "/var/lib/acme/schwem.io/full.pem";
  wildcardCert = "/var/lib/acme/schwem.io-wildcard/full.pem";
in {
  networking.firewall.allowedTCPPorts = [80 443];

  services.haproxy = {
    enable = true;
    config = ''
      defaults
        log global
        mode http
        timeout client 30s
        timeout connect 10s
        timeout server 30s
        timeout http-request 10s
        option forwardfor
        option http-server-close

      listen psql
        bind :26257
        mode tcp
        balance roundrobin
        option clitcpka
        option httpchk GET /health?ready=1
        server articuno articuno.wyvern-map.ts.net:26258 check port 26880
        server zapados zapados.wyvern-map.ts.net:26258 check port 26880
        server moltres moltres.wyvern-map.ts.net:26258 check port 26880

      frontend www
        bind *:80
        bind *:443 ssl crt ${wildcardCert} crt ${baseCert}

        http-request redirect scheme https unless { ssl_fc }
        http-request set-header X-Forwarded-Host %[req.hdr(Host)]
        http-request set-header X-Forwarded-For %[src]
        http-request set-header X-Forwarded-Port %[dst_port]
        http-request set-header X-Forwarded-Proto https
        http-request set-header X-Forwarded-Real-IP %[src]

        acl domain_search hdr(host) -i search.schwem.io

        use_backend searxng if domain_search
        default_backend servers

      backend searxng
        http-request set-header X-Forwarded-Proto https
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend servers
        http-request set-header X-Forwarded-Proto https
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy
        #server moltres moltres.wyvern-map.ts.net:8080 check send-proxy
    '';
  };

  users.users.haproxy.extraGroups = ["acme"];
}
