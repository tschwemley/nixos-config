{pkgs, ...}: let 
    package = pkgs.taskwarrior3;
  in {
  programs.taskwarrior = {
    inherit package;
    enable = true;

    config = {};
  };

  services.taskwarrior-sync = {
    inherit package;
    enable = true;
    frequency = "*:0/30";
  };
}
