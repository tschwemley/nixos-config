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
        # engines:
        #   - name: brave
        #     engine: brave
        #     shortcut: br
        #     time_range_support: true
        #     paging: true
        #     categories: [general, web]
        #     brave_category: search
        #
        #   - name: brave.images
        #     engine: brave
        #     network: brave
        #     shortcut: brimg
        #     categories: [images, web]
        #     brave_category: images
        #
        #   - name: brave.videos
        #     engine: brave
        #     network: brave
        #     shortcut: brvid
        #     categories: [videos, web]
        #     brave_category: videos
        #
        #   - name: brave.news
        #     engine: brave
        #     network: brave
        #     shortcut: brnews
        #     categories: news
        #     brave_category: news
        #
        #   - name: duckduckgo
        #     engine: duckduckgo
        #     shortcut: ddg
        #
        #   - name: google
        #     engine: google
        #     shortcut: go
        #
        #   - name: wallhaven
        #     engine: wallhaven
        #     api_key: ${config.sops.placeholder.wallhaven_api_key}
        #     safesearch_map: "0"
        #     shortcut: wh
        #
        #   - name: wikibooks
        #     engine: mediawiki
        #     weight: 0.5
        #     shortcut: wb
        #     categories: [general, wikimedia]
        #     base_url: "https://{language}.wikibooks.org/"
        #     search_type: text
        #     about:
        #       website: https://www.wikibooks.org/
        #       wikidata_id: Q367
        #         search:
        #             autocomplete: ""
        #             default_lang: en-US
        #             langauges:
        #               - en
        #               - en-US
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
