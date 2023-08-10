{self, lib, ...}: 

{
  perSystem = {pkgs, ...}: let 
    nix-utils = (pkgs.writeShellScriptBin "nix-utils" lib.readFile ./scripts/nix-utils.sh);
  in {
    packages.default = nix-utils;
  };
}
