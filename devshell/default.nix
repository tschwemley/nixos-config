pkgs: {
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      age
      compose2nix
      disko
      nix-prefetch-scripts
      nurl
      scripts.buildHost
      scripts.rotateSecrets
      sops
      ssh-to-age
      statix
      # (writeShellScriptBin "build-host" (builtins.readFile ../scripts/build-host.sh))
    ];
  };
}
