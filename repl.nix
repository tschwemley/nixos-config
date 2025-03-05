let
  curHost = builtins.head (builtins.match "(.*)\n" (builtins.readFile "/etc/hostname"));
  flake = builtins.getFlake (toString ./.);
  self = flake.nixosConfigurations.${curHost};
in
  {
    inherit curHost flake self;
    inherit (flake) lib;
    inherit (self) config pkgs;
  }
  // flake
  // flake.nixosConfigurations
