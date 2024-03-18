{config, ...}: {
  services.prometheus = {
    enable = true;

    scrapeConfigs = [
      {
        # TODO: make this into a loop of server system configs
        job_name = "articuno";
        static_configs = [
          {
            targets = ["articuno:${toString config.services.prometheus.exporters.node.port}"];
          }
        ];
      }
    ];
  };
}
