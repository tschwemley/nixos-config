{
  self,
  config,
  lib,
  ...
}:
{
  imports = with self.inputs; [
    dms.homeModules.dank-material-shell
    dms-plugin-registry.homeModules.default
  ];

  programs = {
    dank-material-shell = {
      enable = true;

      # Core features
      enableAudioWavelength = false; # Audio visualizer (cava)
      enableClipboardPaste = true; # Pasting items from the clipboard (wtype)
      enableDynamicTheming = false; # Wallpaper-based theming (matugen)
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableCalendarEvents = true; # Calendar integration (khal)

      # TODO: unsure if I want to keep these options or not...
      enableVPN = false; # VPN management widget
      # ------

      managePluginSettings = true;

      plugins = {
        calculator.enable = true;
        emojiLauncher.enable = true;

        # base-url: https://openrouter.ai/api/v1
        # api-key: ${config.sops.placeholder.mods_openrouter_api_key}
        aiAssistant = {
          enable = true;
          settings = {
            provider = "custom";
            baseUrl = "https://openrouter.ai/api/v1";
            model = "deepseek/deepseek-v4-flash";
            apiKeyEnvVar = "OPENROUTER_API_KEY";
          };
        };
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
  };

  stylix.targets.dank-material-shell.enable = lib.mkIf (builtins.hasAttr "stylix" config) true;
}
