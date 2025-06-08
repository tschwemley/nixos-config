{pkgs, ...}: {
  home.packages = with pkgs; [
    bk
    bookwork
  ];
}
