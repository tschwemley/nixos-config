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
        bind :5432
        mode tcp

        retries 2
        timeout connect 5s
        timeout client 5m
        timeout server 5m
        option clitcpka

        balance roundrobin
        option httpchk GET /health?ready=1
        server cockroach1 articuno.wyvern-map.ts.net:26257 check port 26080
        server cockroach2 zapados.wyvern-map.ts.net:26257 check port 26080
        server cockroach3 moltres.wyvern-map.ts.net:26257 check port 26080

      frontend www
        bind *:80
        bind *:443 ssl crt ${wildcardCert} crt ${baseCert}

        http-request redirect scheme https unless { ssl_fc }
        http-request set-header X-Forwarded-Host %[req.hdr(Host)]
        http-request set-header X-Forwarded-For %[src]
        http-request set-header X-Forwarded-Port %[dst_port]
        http-request set-header X-Forwarded-Proto https
        http-request set-header X-Forwarded-Real-IP %[src]

        acl domain_db hdr(host) -i db.schwem.io
        acl domain_files hdr(host) -i files.schwem.io
        acl domain_reddit hdr(host) -i reddit.schwem.io
        acl domain_search hdr(host) -i search.schwem.io
        acl domain_stash hdr(host) -i stash.schwem.io

        use_backend cockroach_web if domain_db
        use_backend files if domain_files
        use_backend reddit if domain_reddit
        use_backend searxng if domain_search
        use_backend stash if domain_stash

        default_backend static

      backend cockroach_web
        http-request set-header X-Forwarded-Proto https
        # option httpchk GET /health?ready=1
        balance leastconn

        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy
        server zapados zapados.wyvern-map.ts.net:8080 check send-proxy
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend files
        http-request set-header X-Forwarded-Proto https
        server moltres moltres:9336

      backend reddit
        http-request set-header X-Forwarded-Proto https
        server zapados zapados.wyvern-map.ts.net:8080 check send-proxy
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend searxng
        http-request set-header X-Forwarded-Proto https
        balance roundrobin
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend static
        http-request set-header X-Forwarded-Proto https
        # server articuno articuno.wyvern-map.ts.net:8080 check send-proxy
        # server zapados zapados.wyvern-map.ts.net:8080 check send-proxy
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy
        # server flareon flareon.wyvern-map.ts.net:8080 check send-proxy
        # server jolteon jolteon.wyvern-map.ts.net:8080 check send-proxy

      backend stash
        http-request set-header X-Forwarded-Proto https
        server flareon flareon.wyvern-map.ts.net:8080 check send-proxy
    '';
  };

  sops.secrets = {
    "cockroach-client.pem" = {
      sopsFile = ../cockroachdb/secrets.yaml;
      group = "haproxy";
      mode = "0400";
      path = "/var/lib/haproxy/cockroach-client.pem";
      owner = "haproxy";
    };
  };

  users.users.haproxy.extraGroups = ["acme"];
}
