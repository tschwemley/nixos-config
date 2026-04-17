{
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [ "systemd" ];
  };

  systemd.services.prometheus-node-exporter.stopIfChanged = false;
}
