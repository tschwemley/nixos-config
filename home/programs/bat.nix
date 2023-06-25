{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
    bat-extras.batdiff
    bat-extras.batpipe
    bat-extras.batwatch
  ];
}
