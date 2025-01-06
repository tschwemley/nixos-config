pkgs: {
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      age
      compose2nix
      disko
      nix-prefetch-scripts
      sops
      ssh-to-age
      statix
      (writeShellScriptBin "build-host" (builtins.readFile ../utils/build-host.sh))
    ];
  };
}
