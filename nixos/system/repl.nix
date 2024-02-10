# USAGE: nix repl ./repl.nix --argstr hostname <hostname>
let
  currentHostname = builtins.head (builtins.match "(.*)\n" (builtins.readFile "/etc/hostname"));
  flake = builtins.getFlake (toString ./../..);
in
  {hostname ? currentHostname}: rec {
    inherit flake;
    curSystem = flake.nixosConfigurations.${hostname};
    inherit (curSystem) pkgs lib;
  }