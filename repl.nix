let
  curHost = { curHost = builtins.head (builtins.match "(.*)\n" (builtins.readFile "/etc/hostname"));};
  flake = builtins.getFlake (toString ./.);
  # nixpkgs = import <nixpkgs> { };
in
{ inherit curHost flake; }
// flake
// builtins
# // nixpkgs # NOTE: uncommenting this will make all of nixpkgs load going from ~600 to >~24k vars
# // nixpkgs.lib
// flake.lib
// flake.nixosConfigurations
// curHost
