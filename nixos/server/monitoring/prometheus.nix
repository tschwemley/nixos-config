{config, ...}: {
  imports = [./virtualhost.nix];
  services.prometheus = {
    enable = true;

    # By default setup the node-exporter and it's scraper. Definitions for other services will be
    # in their respective files and/or dirs
    exporters.node = {
      enable = true;
      enabledCollectors = ["systemd"];
    };

    scrapeConfigs = [
      {
        job_name = config.networking.hostName;
        static_configs = [
          {
            targets = ["127.0.0.1:${toString config.services.prometheus.exporters.node.port}"];
          }
        ];
      }
    ];
  };
}
