{pkgs, ...}: {
  environment.systemPackages = let
    repl_path = toString ./.;
    nrepl = pkgs.writeShellScriptBin "nrepl" ''
      source /etc/set-environment
      nix repl "${repl_path}/repl.nix" "$@"
    '';
  in [
    nrepl
  ];
}
# # USAGE: nix repl ./repl.nix --argstr hostname <hostname>
# let
#   currentHostname = builtins.head (builtins.match "(.*)\n" (builtins.readFile "/etc/hostname"));
#   flake = builtins.getFlake (toString ./../..);
# in
#   {hostname ? currentHostname}: rec {
#     inherit
#       (flake)
#       inputs
#       nixosConfigurations
#       packages
#       nixosModules
#       homeModules
#       homeConfigurations
#       ;
#
#     inherit
#       (nixosConfigurations)
#       charizard
#       pikachu
#       articuno
#       zapados
#       moltres
#       eevee
#       jolteon
#       flareon
#       tentacool
#       ;
#
#     curSystem = flake.nixosConfigurations.${hostname};
#     inherit (curSystem) config pkgs lib;
#   }
