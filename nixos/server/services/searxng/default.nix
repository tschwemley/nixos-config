{
  self,
  config,
  lib,
  ...
}: {
  imports = [./secrets.nix];

  services.searx = {
    enable = true;
    environmentFile = config.sops.secrets.searxng_env_file.path;
    redisCreateLocally = true;
    runInUwsgi = true;
    uwsgiConfig = {
      socket = "/run/searx/searx.sock";
      chmod-socket = "660";
    };

    # Rate limiting
    # limiterSettings = {
    #   real_ip = {
    #     x_for = 1;
    #     ipv4_prefix = 32;
    #     ipv6_prefix = 56;
    #   };
    #
    #   botdetection = {
    #     ip_limit = {
    #       filter_link_local = true;
    #       link_token = true;
    #     };
    #   };
    # };

    # Searx configuration
    settings = {
      general = {
        contact_url = false;
        debug = false;
        donation_url = false;
        enable_metrics = true;
        instance_name = "Search Shit";
        privacypolicy_url = false;
      };

      ui = {
        center_alignment = true;
        default_locale = "en";
        default_theme = "simple";
        hotkeys = "vim";
        infinite_scroll = true;
        query_in_title = true;
        search_on_category_select = true;
        static_use_hash = true;
        theme_args.simple_style = "dark";
      };

      # Search engine settings
      search = {
        autocomplete = "startpage";
        autocomplete_min = 2;
        ban_time_on_fail = 5;
        default_lang = "en";
        formats = [
          "html"
          "json"
        ];
        max_ban_time_on_fail = 120;
        safe_search = 0;
      };

      # Server configuration
      server = {
        base_url = "https://search.schwem.io";
        bind_address = "127.0.0.1";
        image_proxy = true;
        # limiter = true;
        limiter = false;
        method = "GET";
        port = lib.strings.toInt self.lib.port-map.searxng;
        public_instance = true;
        secret_key = config.sops.secrets.searxng_secret.path;
      };

      # Engines full list + defaults: https://docs.searxng.org/user/configured_engines.html
      engines = lib.mapAttrsToList (name: value: {inherit name;} // value) {
        # General search ----
        "bing".disabled = false;
        "qwant" = {
          disabled = false;
          weight = 2;
        };

        # duckduckgo instant answer api
        "ddg definitions" = {
          disabled = false;
          weight = 2;
        };

        # File search -------
        "1337x".disabled = false;
        "annas archive".disabled = false;
        "btdigg".disabled = false;
        "openrepos".disabled = false;
        "z-library".disabled = true;

        # Image search ------
        "bing images".disabled = false;
        "deviantart".disabled = false;
        "imgur".disabled = false;
        "google images".disabled = false;
        "openverse".disabled = false;
        "qwant images" = {
          disabled = false;
          weight = 2;
        };
        "svgrepo".disabled = false;
        "unsplash".disabled = false;
        "wallhaven" = {
          disabled = false;
          api_key = "@WALLHAVEN_API_KEY@";
          safesearch_map = "0";
        };

        # Repos search ------
        "codeberg".disabled = false;

        # Video search
        "bing videos".disabled = false;
        "google videos".disabled = false;
        "peertube".disabled = false;
        "qwant videos".disabled = false;

        # wikipedia
        # "wikibooks".disabled = false;
        # "wikicommons.images".disabled = false;
        # "wikidata".disabled = false;
        # "wikispecies" = {
        #   disabled = false;
        #   weight = 0.5;
        # };
        # "wikiversity" = {
        #   disabled = false;
        #   weight = 0.5;
        # };
        # "wikivoyage" = {
        #   disabled = false;
        #   weight = 0.5;
        # };
      };

      # Outgoing requests
      outgoing = {
        request_timeout = 5.0;
        max_request_timeout = 15.0;
        pool_connections = 100;
        pool_maxsize = 15;
        enable_http2 = true;
      };

      # Enabled plugins
      enabled_plugins = [
        "Basic Calculator"
        "Hash plugin"
        "Tor check plugin"
        "Open Access DOI rewrite"
        "Hostnames plugin"
        "Unit converter plugin"
        "Tracker URL remover"
      ];
    };
  };

  services.nginx.virtualHosts."search.schwem.io" = {
    locations = {
      "/" = {
        extraConfig = ''
          uwsgi_pass unix:${config.services.searx.uwsgiConfig.socket};
        '';
      };

      "/api/" = {
        extraConfig = ''
          rewrite /api/ /search?format=json break;
          uwsgi_pass unix:${config.services.searx.uwsgiConfig.socket};
        '';
      };

      "/robots.txt".root = "/etc/nginx/static/";
    };
  };

  users = {
    groups.searx.members = ["nginx"];
    # override with an unused nixos uid value (I already used the default of 201 for cockroachdb)
    users.uwsgi.uid = lib.mkForce 200;
  };
}
