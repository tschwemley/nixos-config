pkgs:
let
  scripts = import ../packages/scripts pkgs;
in
{
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      # nix
      compose2nix
      disko
      nix-output-monitor
      nix-prefetch-scripts
      nix-tree
      nix-update
      nurl
      sops

      # scripts
      scripts.buildHost
      scripts.rotateSecrets

      # utils
      wxedid

      # TODO: Testing... remove if not keeping (01/20/26)
      deadnix
      nvd
      statix

      # (writeShellScriptBin "build-host" (builtins.readFile ../scripts/build-host.sh))
    ];
  };
}
