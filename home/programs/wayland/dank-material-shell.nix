{
  self,
  config,
  lib,
  ...
}:
{
  imports = with self.inputs; [
    dms.homeModules.dank-material-shell
    dms.homeModules.niri

    dms-plugin-registry.modules.default

    danksearch.homeModules.dsearch
  ];

  programs = {
    dank-material-shell = {
      enable = true;

      # Core features
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableVPN = true; # VPN management widget
      enableDynamicTheming = false; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
      enableClipboardPaste = true; # Pasting items from the clipboard (wtype)

      niri.includes.enable = false;

      plugins = {
        calculator.enable = true;
      };

      systemd = {
        enable = true; # Systemd service for auto-start
        restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
      };
    };

    dsearch.enable = true;
  };

  stylix.targets.dank-material-shell.enable = lib.mkIf (builtins.hasAttr "stylix" config) true;
}
