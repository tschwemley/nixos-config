{pkgs, ...}: {
  home.packages = with pkgs; [
    cardinal
    reaper
    # BUG: failing build as of 2025-05-02. Uncomment when working again.
    # NOTE: seems like a problem with ruby dependencies (specifically fetchMix...)
    # TODO: try writing a custom package from a checkpoint of a working derivation
    # sonic-pi
    supercollider
    yabridge
    yabridgectl
  ];
}
