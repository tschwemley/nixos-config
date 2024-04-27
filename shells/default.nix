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
        # BUG: issue with https://github.com/jelmer/dulwich/archive/refs/tags/0.22.1.tar.gz misisng
        # nix-prefetch-scripts
        pkgs.sops
        self'.packages.build-host
        self'.packages.build-all-hosts
        sqlite # this is for if the nix-store fucks me for the Nth time
        ssh-to-age
        wireguard-tools
      ];
    };
  };
}
