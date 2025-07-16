{pkgs, ...}: let
  extraPackages = with pkgs;
    if system == "aarch64-darwin"
    then []
    else [
      # catimg # BUG: uncomment or delete out after upstream bug is fixed
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
    # 0-black, 1-red, 2-green, 3-yellow, 4-blue (default), 5-magenta, 6-cyan, 7-white
    NNN_COLORS = "4652";
    NNN_FCOLORS = "33427561";
    NNN_FIFO = "/tmp/nnn.fifo";
  };

  programs.nnn = {
    inherit extraPackages plugins;
    enable = true;
    bookmarks = {
      "/" = "/";
      "3" = "~/Downloads/3d-prints/";

      D = "~/Downloads";
      h = "~/projects/hir";
      m = "/mnt";
      n = "~/nixos-config";
      p = "~/projects";
      s = "/storage";
    };
  };
}
