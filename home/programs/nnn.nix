{pkgs, ...}: let
  plugins = [];
in {
  programs.nnn = {
    enable = true;
    bookmarks = {
      D = "~/Downloads";
      p = "~/projects";
      n = "~/nixos-config";
    };
    extraPackages = with pkgs; [imv];
    plugins = {
      src = "${pkgs.nnn.src}/plugins";
      mappings = {
        f = "finder";
        p = "preview-tui";
        v = "imgview";
      };
    };
  };
}
