{config, ...}: let
  # mkNodeExporterScrapeConfig = name: {
  #   job_name = "${name}";
  #   static_configs = [
  #     {
  #       targets = ["${name}:${toString config.services.prometheus.exporters.node.port}"];
  #     }
  #   ];
  # };
  target = name: "${name}:${toString config.services.prometheus.exporters.node.port}";
in {
  services.prometheus = {
    enable = true;

    scrapeConfigs = [
      {
        job_name = "node-details";
        static_configs = [
          {
            targets = [
              (target "articuno")
              (target "zapados")
              (target "moltres")
              (target "flareon")
              (target "jolteon")
            ];
          }
        ];
      }
      # (mkNodeExporterScrapeConfig "articuno")
      # (mkNodeExporterScrapeConfig "zapados")
      # (mkNodeExporterScrapeConfig "moltres")
      # (mkNodeExporterScrapeConfig "flareon")
      # (mkNodeExporterScrapeConfig "jolteon")
    ];
  };
}
