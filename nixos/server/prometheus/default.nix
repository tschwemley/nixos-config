{
  imports = [./virtualhost.nix];
  services.prometheus = {
    enable = true;
    exporters = import ./exporters;
  };
}
