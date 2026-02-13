{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cardinal
    # carla
    reaper
    # sonic-pi
    supercollider
    # yabridge
    # yabridgectl

    neural-amp-modeler-lv2
    tuxguitar
  ];

  # home.file."".source = "${pkgs.neural-amp-modeler-lv2}/lib/lv2/neural_amp_modeler.lv2";
}
