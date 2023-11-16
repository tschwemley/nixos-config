{pkgs, ...}: {
  home.packages = with pkgs; [
    gtkcord4
    # discordo # dicord terminal client
  ];
}
