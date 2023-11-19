{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages = {
      # bambuStudio = pkgs.appimageTools.wrapType2 {
      #   name = "bambu-studio";
      #   src = pkgs.fetchurl {
      #     url = "https://github.com/bambulab/BambuStudio/releases/download/v01.08.00.57/Bambu_Studio_linux_ubuntu_v01.08.00.57-20231109141031.AppImage";
      #     hash = "sha256:0h55qvhzj537akygdwwla38c3ycpf2fxl4w2bj2ssb8g07wl5n36";
      #   };
      #   extraPkgs = pkgs:
      #     with pkgs; [
      #       glib-networking
      #       webkitgtk
      #     ];
      # };

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
