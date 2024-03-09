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
        timeout client 10s
        timeout connect 5s
        timeout server 10s
        timeout http-request 10s
        option forwardfor
        option http-server-close

      listen galera-cluster
        bind *:3306
        # balance roundrobin
        mode tcp
        option tcpka
        # option mysql-check user haproxy_check post-41
        # option mysql-check-passwd /path/to/haproxy_mysql_password
        server articuno articuno.wyvern-map.ts.net:3306 check port 3306 inter 2000 rise 2 fall 3
        # server galera-node2 100.a.b.c:3306 check port 3306 inter 2000 rise 2 fall 3
        default-server init-addr none

      listen galera-replication
        bind *:4567
        # balance roundrobin
        mode tcp
        option tcpka
        # option mysql-check user haproxy
        server articuno articuno.wyvern-map.ts.net:4567 check



      frontend www
        bind *:80
        bind *:443 ssl crt ${wildcardCert} crt ${baseCert}
        http-request redirect scheme https unless { ssl_fc }
        http-request set-header X-Forwarded-Host %[req.hdr(Host)]
        http-request set-header X-Forwarded-For %[src]
        http-request set-header X-Forwarded-Port %[dst_port]
        http-request set-header X-Forwarded-Proto https
        http-request set-header X-Forwarded-Real-IP %[src]
        default_backend servers

      backend servers
        http-request set-header X-Forwarded-Proto https
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy
        #server moltres moltres.wyvern-map.ts.net:8080 check send-proxy
    '';
  };

  users.users.haproxy.extraGroups = ["acme"];
}
