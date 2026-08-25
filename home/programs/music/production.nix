{ pkgs, ... }:
{
  home.packages = with pkgs; [
    orca-c
    reaper
    neuralrack
    neural-amp-modeler-lv2
    ratatouille-lv2
    supercollider
    tuxguitar
    yabridge
    yabridgectl
  ];
}
