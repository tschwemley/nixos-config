{ pkgs, ... }:
# Wayland config
{
  imports = [
    ./dux
    ./niri
  ];

  home = {
    packages = with pkgs; [
      nautilus

      wl-clipboard
      wl-ocr
      wlr-randr
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
