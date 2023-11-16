{self, ...}: {
  perSystem = {
    pkgs,
    system,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        self.inputs.nixos-generators.packages.${system}.nixos-generate
        age
        manix
        nix-prefetch-scripts
        pkgs.sops
        sqlite # this is for if the nix-store fucks me for the Nth time
        ssh-to-age
        wireguard-tools
      ];
    };
  };
}
