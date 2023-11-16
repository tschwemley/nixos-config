{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages = {
      # see: https://github.com/NixOS/nixpkgs/pull/206495/files for merge
      # bambuStudio = pkgs.stdenv.mkDerivation {};

      hyprbars = let
        hyprland = pkgs.hyprland;
      in
        pkgs.stdenv.mkDerivation {
          pname = "hyprbars";
          version = "0.1";
          src = pkgs.fetchFromGitHub {
            owner = "hyprwm";
            repo = "hyprland-plugins";
            rev = "b5d0cfdff726676b8c6df564fdb1732558d6c25b";
            sha256 = "sha256-US7WfYWqMax+uEaRPpCOn8ib2pLYDLa5Fy8dIjWH0aM=";
          };
          sourceRoot = "source/hyprbars";

          inherit (hyprland) nativeBuildInputs;

          buildInputs = [hyprland] ++ hyprland.buildInputs;
        };
    };
  };
}
