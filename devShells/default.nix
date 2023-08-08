{self, ...}: {
  perSystem = {
    pkgs,
    system,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        age
        manix
        self.inputs.nixos-generators.packages.${system}.nixos-generate
        pkgs.sops
        sqlite # this is for if the nix-store fucks me for the Nth time
        ssh-to-age
        wireguard-tools
      ];
    };
  };
}
