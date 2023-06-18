{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    bat-extras.batdiff
    bat-extras.batpipe
    bat-extras.batwatch
  ];
}
