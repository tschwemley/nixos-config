{
  self,
  config,
  lib,
  ...
}:
{
  imports = with self.inputs.dms.homeModules; [
    dank-material-shell
    niri
  ];

  programs.dank-material-shell = {
    enable = true;

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = false; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting items from the clipboard (wtype)

    niri.includes.enable = false;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
    };

  };

  stylix.targets.dank-material-shell.enable = lib.mkIf (builtins.hasAttr "stylix" config) true;

  xdg.mimeApps.defaultApplications = lib.xdgAssociations "x-scheme-handler" "dms-open.desktop" [
    "http"
    "https"
  ];
}
