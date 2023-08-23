{lib, ...}: let
  mkAppFromScript = name: pkgs: scriptPath: {
    type = "app";
    program = pkgs.writeShellScriptBin name lib.readFile scriptPath;
  };
in {
  perSystem = {pkgs, ...}: let
    nix-utils = pkgs.writeShellScriptBin "nix-utils" lib.readFile ./scripts/nix-utils.sh;
  in {
    apps.default = mkAppFromScript "nix-utils" pkgs ./scripts/nix-utils.sh;
  };
}
