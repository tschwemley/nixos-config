{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cardinal
    orca-c
    reaper
    supercollider
    yabridge
    yabridgectl

    neural-amp-modeler-lv2
    tuxguitar

    # TODO: remove after evaluating for usage
    # carla
    # sonic-pi
  ];

  # home.file."".source = "${pkgs.neural-amp-modeler-lv2}/lib/lv2/neural_amp_modeler.lv2";
}
