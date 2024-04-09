{pkgs, ...}: {
  home.packages = with pkgs; [
    cardinal
    reaper
    sonic-pi
    supercollider
  ];
}
