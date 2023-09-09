{pkgs, ...}: {
  home.packages = with pkgs; [
    webcord
    # gtkcord4
    # discordo # dicord terminal client
  ];
}
