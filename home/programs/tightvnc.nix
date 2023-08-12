{pkgs, ...}: {
  home.packages = with pkgs; [
    tightvnc
  ];
}
