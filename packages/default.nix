{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages = {
      # see: https://github.com/NixOS/nixpkgs/pull/206495/files for merge
      # bambuStudio = pkgs.stdenv.mkDerivation {};
    };
  };
}
