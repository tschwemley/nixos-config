{ pkgs, ... }:
{
  home.packages = with pkgs; [
    demucs-rs
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
