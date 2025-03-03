let
  host = builtins.head (builtins.match "(.*)\n" (builtins.readFile "/etc/hostname"));
  flake = builtins.getFlake (toString ./.);

  inherit (flake.nixosConfigurations.${host}) pkgs;
in
  {
    inherit flake;
    curHost = host;
  }
  // flake
  // builtins
  # // nixpkgs # NOTE: uncommenting this will make all of nixpkgs load going from ~600 to >~24k vars
  // flake.lib
  // flake.nixosConfigurations
  // host
  // pkgs
