{config, ...}: {
  sops.secrets.server_secret_key = {
    sopsFile = ./secrets.yaml;
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
        # engine:
        search:
            autocomplete: ""
            default_lang: en-US
            langauges:
              - en
              - en-US
        server:
            base_url: https://search.schwem.io
            port: 8888
            secret_key: ${config.sops.placeholder.server_secret_key}
        ui:
            default_theme: simple
            infinite_scroll: true
      '';
  };
}
