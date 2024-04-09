{pkgs, ...}: {
  imports = with pkgs; [
    cardinal
    reaper
    sonic-pi
    supercollider
  ];
}
