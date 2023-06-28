{pkgs, ...}: {
  programs.bat = {
    enable = true;
    extraPackages = with pkgs; [
      bat-extras.batdiff
      bat-extras.batpipe
      bat-extras.batwatch
    ];
  };
}
