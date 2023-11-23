{pkgs, ...}: {
  home.packages = with pkgs; [
    # webcord
    gtkcord4
  ];
}
