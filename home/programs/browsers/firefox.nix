{pkgs, ...}: {
  home.packages = with pkgs; [firefox-bin];
}
