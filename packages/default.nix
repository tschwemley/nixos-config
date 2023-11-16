{self, lib, ...}: {
  perSystem = {pkgs, ...}: {
    packages.default = pkgs.writeShellScript "" lib.readFile ./scripts/nix-utils.sh;
  };
}
