{...}: {
  perSystem = {
    self',
    pkgs,
    system,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        age
        manix
        nix-prefetch-scripts
        pkgs.sops
        self'.packages.build-host
        sqlite # this is for if the nix-store fucks me for the Nth time
        ssh-to-age
        wireguard-tools
      ];
    };
  };
}
