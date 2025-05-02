let
  curHost = builtins.head (builtins.match "(.*)\n" (builtins.readFile "/etc/hostname"));
  flake = builtins.getFlake (toString ./.);
  self = flake.nixosConfigurations.${curHost};

  username = if (self.config.home-manager.users ? schwem) then "schwem" else "root";
  hm = self.config.home-manager.users.${username};
in
  {
    inherit curHost flake self hm;
    inherit (flake) lib;
    inherit (self) config pkgs;
    inherit (self.pkgs) system;
  }
// flake.nixosConfigurations
  // flake
