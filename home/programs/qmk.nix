{pkgs, ...}: {
  home.packages = with pkgs; [qmk qmk_hid];
}
