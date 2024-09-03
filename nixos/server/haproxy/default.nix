let
  baseCert = "/var/lib/acme/schwem.io/full.pem";
  wildcardCert = "/var/lib/acme/schwem.io-wildcard/full.pem";
in
{
  networking.firewall.allowedTCPPorts = [
    80
    443
    2222
  ];

  services.haproxy = {
    enable = true;
    # TODO: WIP: finish converting config into an opt for my needs
    config = ''
      defaults
        log global
        mode http
        timeout client 30s
        timeout connect 10s
        timeout server 30s
        timeout http-request 10s

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

      listen ssh
        bind *:2222
        mode tcp

        acl git req_ssl_sni -i git.schwem.io
        use_backend git if git

      frontend www
        bind *:80
        bind *:443 ssl crt ${wildcardCert} crt ${baseCert}

        option forwarded
        option forwardfor
        option http-server-close

        http-request redirect scheme https unless { ssl_fc }
        http-request set-header X-Forwarded-Host %[req.hdr(Host)]
        http-request set-header X-Forwarded-For %[src]
        http-request set-header X-Forwarded-Port %[dst_port]
        http-request set-header X-Forwarded-Proto https
        http-request set-header X-Forwarded-Real-IP %[src]

        acl domain_auth hdr(host) -i auth.schwem.io
        acl domain_db hdr(host) -i db.schwem.io
        acl domain_draw hdr(host) -i draw.schwem.io
        acl domain_git hdr(host) -i git.schwem.io
        acl domain_it-tools hdr(host) -i it-tools.schwem.io
        acl domain_jellyfin hdr(host) -i jellyfin.schwem.io
        acl domain_jellyseerr hdr(host) -i jellyseerr.schwem.io
        acl domain_medium hdr(host) -i medium.schwem.io
        acl domain_monitor hdr(host) -i monitor.schwem.io
        acl domain_reddit hdr(host) -i reddit.schwem.io
        acl domain_search hdr(host) -i search.schwem.io
        acl domain_stackoverflow hdr(host) -i so.schwem.io

        use_backend auth if domain_auth
        use_backend cockroach_web if domain_db
        use_backend draw if domain_draw
        use_backend git if domain_git
        use_backend it-tools if domain_it-tools
        use_backend jellyfin if domain_jellyfin
        use_backend jellyseerr if domain_jellyseerr
        use_backend medium if domain_medium
        use_backend monitor if domain_monitor
        use_backend reddit if domain_reddit
        use_backend searxng if domain_search
        use_backend stackoverflow if domain_stackoverflow

        default_backend static

      backend auth
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy

      backend cockroach_web
        http-request set-header X-Forwarded-Proto https
        # option httpchk GET /health?ready=1
        balance leastconn

        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy
        server zapados zapados.wyvern-map.ts.net:8080 check send-proxy
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend draw
        http-request set-header X-Forwarded-Proto https
        server zapados zapados.wyvern-map.ts.net:8080 check send-proxy

      backend git
        http-request set-header X-Forwarded-Proto https
        server jolteon jolteon.wyvern-map.ts.net:8080 check send-proxy

      backend it-tools
        http-request set-header X-Forwarded-Proto https
        server zapados zapados.wyvern-map.ts.net:8080 check send-proxy

      backend jellyfin
        http-request set-header X-Forwarded-Proto https
        server tentacool tentacool.wyvern-map.ts.net:8080 check send-proxy

      backend jellyseerr
        http-request set-header X-Forwarded-Proto https
        server tentacool tentacool.wyvern-map.ts.net:8080 check send-proxy

      backend medium
        http-request set-header X-Forwarded-Proto https
        server jolteon jolteon.wyvern-map.ts.net:8080 check send-proxy

      backend monitor
        http-request set-header X-Forwarded-Proto https
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy

      backend reddit
        http-request set-header X-Forwarded-Proto https
        #server zapados zapados.wyvern-map.ts.net:8080 check send-proxy
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend searxng
        http-request set-header X-Forwarded-Proto https
        balance roundrobin
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend static
        http-request set-header X-Forwarded-Proto https
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend stackoverflow
        http-request set-header X-Forwarded-Proto https
        server jolteon jolteon.wyvern-map.ts.net:8080 check send-proxy
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

  users.users.haproxy.extraGroups = [ "acme" ];
}
