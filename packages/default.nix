{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages = {
      hyprbars = let
        hyprland = pkgs.hyprland;
      in
        pkgs.stdenv.mkDerivation {
          pname = "hyprbars";
          version = "0.1";
          src = pkgs.fetchFromGitHub {
            owner = "hyprwm";
            repo = "hyprland-plugins";
            rev = "33c3ced2c28eb228f64d637904a4070dc748457a";
            sha256 = "sha256-UGEwNcnIYUESei7vWLlFwkjOJhu1rQQm3t+P5t175LE=";
          };
          sourceRoot = "source/hyprbars";

          inherit (hyprland) nativeBuildInputs;

          buildInputs = [hyprland] ++ hyprland.buildInputs;
        };
    };
  };
}
