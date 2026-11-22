{
  self,
  config,
  lib,
  ...
}:
{
  imports = with self.inputs; [
    dfiles.homeModules.dux-files
    dsearch.homeModules.dsearch
    dms.homeModules.dank-material-shell
    dms-plugin-registry.homeModules.default
  ];

  programs = {
    dank-material-shell = {
      enable = true;

      # Core features
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableClipboardPaste = true; # Pasting items from the clipboard (wtype)
      enableDynamicTheming = true; # Wallpaper-based theming (matugen)
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableCalendarEvents = true; # Calendar integration (khal)

      # TODO: unsure if I want to keep these options or not...
      enableVPN = false; # VPN management widget
      # ------

      managePluginSettings = true;

      # niri = {
      #   enableKeybinds = false;
      #   enableSpawn = false;
      #   includes.enable = false;
      # };

      plugins = {
        calculator.enable = true;
        emojiLauncher.enable = true;
      };

      settings = {
        bluetoothDevicePins.preferredDevice = [ "3C:B0:ED:A8:DE:DA" ];
        theme = "dark";
      };

      systemd = {
        enable = true; # Systemd service for auto-start
        restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
      };
    };

    dsearch = {
      enable = true;
    };

    dux-files = {
      enable = true;
    };
  };

  stylix.targets.dank-material-shell.enable = lib.mkIf (builtins.hasAttr "stylix" config) true;
}
