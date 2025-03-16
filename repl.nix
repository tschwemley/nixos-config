let
  curHost = builtins.head (builtins.match "(.*)\n" (builtins.readFile "/etc/hostname"));
  flake = builtins.getFlake (toString ./.);
  self = flake.nixosConfigurations.${curHost};
  testHosts = import ./test-hosts.nix;
in
  {
    inherit curHost flake self testHosts;
    inherit (flake) lib;
    inherit (self) config pkgs;
    inherit (self.pkgs) system;
  }
  // flake
  // flake.nixosConfigurations
