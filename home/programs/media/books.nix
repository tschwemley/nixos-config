{pkgs, ...}: {
  home.packages = with pkgs; [
    bk
    calibre
  ];
}
