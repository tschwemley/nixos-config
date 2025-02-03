{config, ...}: let
  mkNodeExporterScrapeConfig = name: {
    job_name = "${name}";
    static_configs = [
      {
        targets = ["${name}:${toString config.services.prometheus.exporters.node.port}"];
      }
    ];
  };
in {
  services.prometheus = {
    enable = true;

    scrapeConfigs = [
      (mkNodeExporterScrapeConfig "articuno")
      (mkNodeExporterScrapeConfig "zapados")
      (mkNodeExporterScrapeConfig "moltres")
      (mkNodeExporterScrapeConfig "flareon")
      (mkNodeExporterScrapeConfig "jolteon")
    ];
  };
}
