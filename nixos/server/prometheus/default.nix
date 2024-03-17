{
  services.prometheus = let
    exporters = import ./exporters;
  in {
    inherit exporters;

    enable = true;
  };
}
