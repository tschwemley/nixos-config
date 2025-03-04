let
  curHost = builtins.head (builtins.match "(.*)\n" (builtins.readFile "/etc/hostname"));
  flake = builtins.getFlake (toString ./.);
in
  {
    inherit curHost flake;
    inherit (flake) lib;
    inherit (flake.nixosConfigurations.${curHost}) pkgs;
    config = flake.nixosConfigurations.${curHost};
  }
  // flake
  // flake.nixosConfigurations
