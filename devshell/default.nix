pkgs: {
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      compose2nix
      disko
      nix-output-monitor
      nix-prefetch-scripts
      nix-tree
      nix-update
      nurl
      scripts.buildHost
      scripts.rotateSecrets
      sops
      # (writeShellScriptBin "build-host" (builtins.readFile ../scripts/build-host.sh))
    ];
  };
}
