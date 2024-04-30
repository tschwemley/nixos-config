{
  lib,
  pkgs,
  ...
}: let
  extraPackages = with pkgs;
    if system == "aarch64-darwin"
    then []
    else
    [
      catimg
      ffmpeg
      ffmpegthumbnailer
      xdragon
    ];
  plugins =
    if pkgs.system == "aarch64-darwin"
    then {}
    else {
      src = "${pkgs.nnn.src}/plugins";
      mappings = {
        d = "dragdrop";
        f = "finder";
        n = "nuke";
        p = "preview-tui";
        v = "imgview";
        x = "togglex";
      };
    };
in {
  home.sessionVariables = {
    NNN_FIFO = "/tmp/nnn.fifo";
  };
  programs.nnn = {
    inherit extraPackages plugins;
    enable = true;
    bookmarks = {
      "3" = "~/Downloads/3d-prints/";
      D = "~/Downloads";
      a = "~/projects/ai";
      h = "~/projects/hir/casino_server";
      p = "~/projects";
      n = "~/nixos-config";
    };
  };
}
