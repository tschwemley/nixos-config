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

    # TODO: make this not shit
    scrapeConfigs = [
      (mkNodeExporterScrapeConfig "articuno")
      (mkNodeExporterScrapeConfig "zapados")
      (mkNodeExporterScrapeConfig "moltres")
      (mkNodeExporterScrapeConfig "eevee")
      (mkNodeExporterScrapeConfig "flareon")
      (mkNodeExporterScrapeConfig "jolteon")
    ];
  };
}
