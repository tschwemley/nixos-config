{pkgs, ...}: {
  home.packages = with pkgs; [
    nzbget
    rar
  ];
}
