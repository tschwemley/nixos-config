{ config, lib, ... }:
{
  services.searx = {
    enable = true;
    redisCreateLocally = true;

    # Rate limiting
    limiterSettings = {
      real_ip = {
        x_for = 1;
        ipv4_prefix = 32;
        ipv6_prefix = 56;
      };

      botdetection = {
        ip_limit = {
          filter_link_local = true;
          link_token = true;
        };
      };
    };

    # UWSGI configuration
    runInUwsgi = true;

    uwsgiConfig = {
      socket = "/run/searx/searx.sock";
      http = ":${config.portMap.searxng}";
      chmod-socket = "660";
    };

    # Searx configuration
    settings = {
      # Instance settings
      general = {
        contact_url = false;
        debug = false;
        donation_url = false;
        enable_metrics = true;
        instance_name = "Search Shit";
        privacypolicy_url = false;
      };

      # User interface
      ui = {
        center_alignment = true;
        default_locale = "en";
        default_theme = "simple";
        hotkeys = "vim";
        infinite_scroll = false;
        query_in_title = true;
        search_on_category_select = false;
        static_use_hash = true;
        theme_args.simple_style = "auto";
      };

      # Search engine settings
      search = {
        safe_search = 0;
        autocomplete_min = 2;
        autocomplete = "duckduckgo";
        ban_time_on_fail = 5;
        default_lang = "en";
        max_ban_time_on_fail = 120;
      };

      # Server configuration
      server = {
        base_url = "https://search.schwem.io";
        port = lib.strings.toInt config.portMap.searxng;
        bind_address = "127.0.0.1";
        secret_key = config.sops.secrets.searxng_secret.path;
        limiter = true;
        public_instance = true;
        image_proxy = true;
        method = "GET";
      };

      # Search engines
      engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
        "1x".disabled = true;
        "artic".disabled = false;
        "bing images".disabled = false;
        "bing videos".disabled = false;
        "bing".disabled = false;
        "brave".disabled = true;
        "brave.images".disabled = true;
        "brave.news".disabled = true;
        "brave.videos".disabled = true;

        "crowdview" = {
          disabled = false;
          weight = 0.5;
        };

        "curlie".disabled = true;
        "currency".disabled = true;
        "dailymotion".disabled = true;

        "ddg definitions" = {
          disabled = false;
          weight = 2;
        };

        "deviantart".disabled = false;
        "dictzone".disabled = true;
        "duckduckgo images".disabled = true;
        "duckduckgo videos".disabled = true;
        "duckduckgo".disabled = true;
        "flickr".disabled = true;
        "google images".disabled = false;
        "google news".disabled = true;
        "google play movies".disabled = true;
        "google videos".disabled = false;
        "imgur".disabled = false;
        "invidious".disabled = true;
        "library of congress".disabled = false;
        "lingva".disabled = true;

        "material icons" = {
          disabled = true;
          weight = 0.2;
        };

        "mojeek".disabled = true;
        "mwmbl" = {
          disabled = false;
          weight = 0.4;
        };

        "odysee".disabled = true;
        "openverse".disabled = false;
        "peertube".disabled = false;
        "pinterest".disabled = true;
        "piped".disabled = true;
        "qwant images".disabled = true;
        "qwant videos".disabled = false;
        "qwant".disabled = true;
        "rumble".disabled = false;
        "sepiasearch".disabled = false;
        "svgrepo".disabled = false;
        "unsplash".disabled = false;
        "vimeo".disabled = true;

        "wallhaven" = {
          disabled = false;
          # api_key = config.sops.placeholder.wallhaven_api_key.path;
          safesearch_map = "0";
        };

        "wikibooks".disabled = false;
        "wikicommons.images".disabled = false;
        "wikidata".disabled = false;
        "wikiquote".disabled = true;
        "wikisource".disabled = true;

        "wikispecies" = {
          disabled = false;
          weight = 0.5;
        };

        "wikiversity" = {
          disabled = false;
          weight = 0.5;
        };

        "wikivoyage" = {
          disabled = false;
          weight = 0.5;
        };

        "yacy images".disabled = true;
        "youtube".disabled = false;
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

  sops.secrets = {
    searxng_secret = {
      sopsFile = ./secrets.yaml;
    };
    wallhaven_api_key = {
      sopsFile = ./secrets.yaml;
    };
  };

  systemd.services.nginx.serviceConfig.ProtectHome = false;

  users = {
    groups.searx.members = [ "nginx" ];
    # override with an unused nixos uid value (I already used the default of 201 for cockroachdb)
    users.uwsgi.uid = lib.mkForce 200;
  };

  services.nginx.virtualHosts."search.schwem.io" = {
    locations = {
      "/" = {
        extraConfig = ''
          uwsgi_pass unix:${config.services.searx.uwsgiConfig.socket};
        '';
      };
    };
  };
}
