{ pkgs, ... }:
# Wayland config
{
  imports = [
    ./fuzzel.nix
    ./swaylock.nix
    ./waybar
  ];

  home = {
    packages = with pkgs; [
      cliphist

      slurp # utility that gives x,y && w x h coordinates for a selection
      wl-clipboard
      wl-ocr
      wf-recorder

      wlr-randr
      ydotool
    ];

    # ensure proper hinting for electron applications
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
