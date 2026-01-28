{ pkgs, ... }:
{
  # TODO: split this up further than just "production"
  home.packages = with pkgs; [
    cardinal
    # carla
    reaper
    # sonic-pi
    supercollider
    # yabridge
    # yabridgectl

    tuxguitar

    # TODO: also look into similar projects e.g.
    #         [proteus](https://guitarml.com/#products)
    #         [amperium nnm](https://www.st-rock.com/vst/)
    neural-amp-modeler-lv2
  ];

  # home.file."".source = "${pkgs.neural-amp-modeler-lv2}/lib/lv2/neural_amp_modeler.lv2";
}
