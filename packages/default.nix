{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages = let
      hyprland = pkgs.hyprland;
    in {
      # see: https://github.com/NixOS/nixpkgs/pull/206495/files for merge
      # bambuStudio = pkgs.stdenv.mkDerivation {};
      hyprbars = pkgs.stdenv.mkDerivation {
        pname = "hyprbars";
        version = "0.1";
        src = pkgs.fetchFromGitHub {
          owner = "hyprwm";
          repo = "hyprland-plugins";
          rev = "f9578d28d272fb61753417e175b0fcd5bedc1443";
          sha256 = "sha256-TYsRfn8LLNPNQ0B4LgrGQmXZJrdAtwttRZSxLp1yqVc=";
        };
        sourceRoot = "source/hyprbars";

        inherit (hyprland) nativeBuildInputs;

        buildInputs = [hyprland] ++ hyprland.buildInputs;
      };
    };
  };
}
