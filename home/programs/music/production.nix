{pkgs, ...}: {
  home.packages = with pkgs; [
    cardinal
    reaper
    # BUG: failing build as of 2025-05-02. Uncomment when working again. 
    # sonic-pi
    supercollider
    yabridge
    yabridgectl
  ];
}
