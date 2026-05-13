{ pkgs, ... }:
# Wayland config
{
  imports = [
    ./dank-material-shell.nix
    # ./fuzzel.nix
    ./niri
    # ./swaylock.nix
    # ./waybar
  ];

  home = {
    packages = with pkgs; [
      wl-clipboard
      wl-ocr
      wlr-randr

      # slurp # utility that gives x,y && w x h coordinates for a selection
      # wf-recorder

      # ydotool
    ];

    # ensure proper hinting for electron applications
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
