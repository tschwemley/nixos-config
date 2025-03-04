{
  imports = [
    ./options.nix
  ];

  variables = {
    ports = import ./port-map.nix;
  };
}
