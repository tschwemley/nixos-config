{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    ollama = import ./ollama;
  in {
    packages = {
      inherit ollama;
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
    };
  };
}
