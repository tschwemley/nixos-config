{
  pkgs,
  system,
  ...
}: {
  home.sessionVariables = {
    NNN_FIFO = "/tmp/nnn.fifo";
  };
  programs.nnn = {
    enable = true;
    bookmarks = {
      D = "~/Downloads";
      p = "~/projects";
      n = "~/nixos-config";
    };
    extraPackages =
      if system == "aarch64-darwin"
      then []
      else with pkgs; [imv];
    plugins =
      if system == "aarch64-darwin"
      then {}
      else {
        src = "${pkgs.nnn.src}/plugins";
        mappings = {
          f = "finder";
          p = "preview-tui";
          v = "imgview";
        };
      };
  };
}
