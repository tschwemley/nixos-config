{config, ...}: {
  sops.secrets = {
    server_secret_key = {sopsFile = ./secrets.yaml;};
    wallhaven_api_key = {sopsFile = ./secrets.yaml;};
  };

  sops.templates."searxng_settings.yaml" = {
    mode = "0444";
    content =
      /*
      yaml
      */
      ''
        use_default_settings: true
        general:
            debug: false
            instance_name: Search
        engines:
          - name: wallhaven
            api_key: ${config.sops.placeholder.wallhaven_api_key}
            safesearch_map: "0"
          - name: wikibooks
            disabled: false
        server:
            base_url: https://search.schwem.io
            port: 8888
            secret_key: ${config.sops.placeholder.server_secret_key}
        ui:
            default_theme: simple
            theme_args:
              simple_style: dark
            infinite_scroll: true
      '';
  };
}
