{
  services.prometheus = {
    enable = true;
    exporters = import ./exporters;
  };
}
