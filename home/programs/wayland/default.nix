{ pkgs, ... }:
# Wayland config
{
  imports = [
    ./dank-material-shell.nix
    ./niri
  ];

  home = {
    packages = with pkgs; [
      nautilus

      wl-clipboard
      wl-ocr
      wlr-randr

      # slurp # utility that gives x,y && w x h coordinates for a selection
      # wf-recorder

      # ydotool
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
