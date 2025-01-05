pkgs: {
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      age
      compose2nix
      nix-prefetch-scripts
      sops
      # self'.packages.build-host
      ssh-to-age
      statix
    ];
  };
}
