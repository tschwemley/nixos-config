# USAGE: nix repl ./repl.nix --argstr hostname <hostname>
let
  currentHostname = builtins.head (builtins.match "(.*)\n" (builtins.readFile "/etc/hostname"));
  flake = builtins.getFlake (toString ./../..);
in
  {hostname ? currentHostname}: rec {
    inherit flake;
    inherit (flake.nixosConfigurations) charizard articuno zapados moltres eevee jolteon flareon pikachu;
    curSystem = flake.nixosConfigurations.${hostname};
    inherit (curSystem) pkgs lib;
  }
