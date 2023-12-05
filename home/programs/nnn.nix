{pkgs, ...}: let
  extraPackages =
    if pkgs.system == "aarch64-darwin"
    then []
    else
      with pkgs; [
        imv
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
      D = "~/Downloads";
      p = "~/projects";
      n = "~/nixos-config";
    };
  };
}
