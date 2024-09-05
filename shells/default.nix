{
  perSystem =
    {
      self',
      pkgs,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          age
          # BUG: issue with https://github.com/jelmer/dulwich/archive/refs/tags/0.22.1.tar.gz misisng
          # nix-prefetch-scripts
          sops
          self'.packages.build-host
          self'.packages.build-all-hosts
          ssh-to-age
        ];
      };
    };
}
