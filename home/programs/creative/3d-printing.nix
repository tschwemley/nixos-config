{pkgs, ...}: {
  home.packages = with pkgs; [
    # bambu-studio
    orca-slicer
  ];
}
