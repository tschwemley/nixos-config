let
  baseCert = "/var/lib/acme/schwem.io/full.pem";
  wildcardCert = "/var/lib/acme/schwem.io-wildcard/full.pem";
  wildcardApiCert = "/var/lib/acme/schwem.io-wildcard-api/full.pem";
in {
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

      frontend git_ssh
        bind git.schwem.io:2222
        mode tcp
        default_backend git_ssh

      frontend www
        bind *:80
        bind *:443 ssl crt ${wildcardCert} crt ${baseCert} crt ${wildcardApiCert}

        mode http

        option forwarded
        option forwardfor
        option http-server-close

        http-request redirect scheme https unless { ssl_fc }
        http-request set-header X-Forwarded-Host %[req.hdr(Host)]
        http-request set-header X-Forwarded-For %[src]
        http-request set-header X-Forwarded-Port %[dst_port]
        http-request set-header X-Forwarded-Proto https
        http-request set-header X-Forwarded-Real-IP %[src]

        acl domain_default hdr(host) -i schwem.io

        acl domain_ai hdr(host) -i ai.schwem.io
        acl domain_auth hdr(host) -i auth.schwem.io
        acl domain_cyberchef hdr(host) -i cyberchef.schwem.io
        acl domain_db hdr(host) -i db.schwem.io
        acl domain_draw hdr(host) -i draw.schwem.io
        acl domain_git hdr(host) -i git.schwem.io
        acl domain_freetar hdr(host) -i freetar.schwem.io
        acl domain_it-tools hdr(host) -i it-tools.schwem.io
        acl domain_jellyfin hdr(host) -i jellyfin.schwem.io
        acl domain_jellyseerr hdr(host) -i jellyseerr.schwem.io
        acl domain_medium hdr(host) -i medium.schwem.io
        acl domain_monitor hdr(host) -i monitor.schwem.io
        acl domain_pinterest hdr(host) -i pinterest.schwem.io
        acl domain_reddit hdr(host) -i reddit.schwem.io
        acl domain_rimgo hdr(host) -i rimgo.schwem.io
        acl domain_search hdr(host) -i search.schwem.io
        acl domain_stackoverflow hdr(host) -i so.schwem.io
        acl domain_tiktok hdr(host) -i tiktok.schwem.io
        acl domain_threadfin hdr(host) -i threadfin.schwem.io
        acl domain_tumblr hdr(host) -i tumblr.schwem.io
        acl domain_twitch hdr(host) -i twitch.schwem.io twitch.api.schwem.io
        acl domain_wiki hdr(host) -i wiki.schwem.io

        use_backend articuno if domain_ai
        use_backend auth if domain_auth
        use_backend articuno if domain_default
        use_backend articuno if domain_cyberchef
        use_backend draw if domain_draw
        use_backend freetar if domain_freetar
        use_backend git if domain_git
        use_backend it-tools if domain_it-tools
        use_backend jellyfin if domain_jellyfin
        use_backend jellyseerr if domain_jellyseerr
        use_backend medium if domain_medium
        use_backend monitor if domain_monitor
        use_backend pinterest if domain_pinterest
        use_backend reddit if domain_reddit
        use_backend rimgo if domain_rimgo
        use_backend searxng if domain_search
        use_backend stackoverflow if domain_stackoverflow
        use_backend tiktok if domain_tiktok
        use_backend threadfin if domain_threadfin
        use_backend tumblr if domain_tumblr
        use_backend twitch if domain_twitch
        use_backend wiki if domain_wiki

        default_backend static

      backend articuno
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy

      backend auth
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy

      backend draw
        http-request set-header X-Forwarded-Proto https
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend freetar
        http-request set-header X-Forwarded-Proto https
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend git
        http-request set-header X-Forwarded-Proto https
        server jolteon jolteon.wyvern-map.ts.net:8080 check send-proxy

      backend git_ssh
        mode tcp
        server jolteon_ssh jolteon:2222 check
        # server zapados zapados:2222 check

      backend it-tools
        http-request set-header X-Forwarded-Proto https
        server zapados zapados.wyvern-map.ts.net:8080 check send-proxy

      backend jellyfin
        http-request set-header X-Forwarded-Proto https
        server tentacool tentacool.wyvern-map.ts.net:8080 check send-proxy

      backend jellyseerr
        http-request set-header X-Forwarded-Proto https
        server tentacool tentacool.wyvern-map.ts.net:8080 check send-proxy

      backend jolteon
        http-request set-header X-Forwarded-Proto https
        server jolteon jolteon:8080 check send-proxy

      backend medium
        http-request set-header X-Forwarded-Proto https
        server jolteon jolteon.wyvern-map.ts.net:8080 check send-proxy

      backend monitor
        http-request set-header X-Forwarded-Proto https
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy

      backend pinterest
        http-request set-header X-Forwarded-Proto https
        server zapados zapados.wyvern-map.ts.net:8080 check send-proxy

      backend reddit
        http-request set-header X-Forwarded-Proto https
        #server zapados zapados.wyvern-map.ts.net:8080 check send-proxy
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend rimgo
        http-request set-header X-Forwarded-Proto https
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend searxng
        http-request set-header X-Forwarded-Proto https
        # balance roundrobin
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy
        # server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend static
        http-request set-header X-Forwarded-Proto https
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend stackoverflow
        http-request set-header X-Forwarded-Proto https
        server jolteon jolteon.wyvern-map.ts.net:8080 check send-proxy

      backend tiktok
        http-request set-header X-Forwarded-Proto https
        server articuno articuno.wyvern-map.ts.net:8080 check send-proxy

      backend threadfin
        http-request set-header X-Forwarded-Proto https
        server moltres moltres.wyvern-map.ts.net:8080 check send-proxy

      backend tumblr
        http-request set-header X-Forwarded-Proto https
        server zapados zapados.wyvern-map.ts.net:8080 check send-proxy

      backend twitch
        http-request set-header X-Forwarded-Proto https
        server zapados zapados.wyvern-map.ts.net:8080 check send-proxy

      backend wiki
        http-request set-header X-Forwarded-Proto https
        server zapados zapados:8080 check send-proxy

    '';
  };

  users.users.haproxy.extraGroups = ["acme"];
}
