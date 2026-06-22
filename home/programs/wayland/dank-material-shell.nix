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

    dms-plugin-registry.homeModules.default

    danksearch.homeModules.dsearch
  ];

  programs = {
    dank-material-shell = {
      enable = true;

      # Core features
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
      enableClipboardPaste = true; # Pasting items from the clipboard (wtype)
      enableDynamicTheming = false; # Wallpaper-based theming (matugen)
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableVPN = true; # VPN management widget

      managePluginSettings = true;

      niri = {
        enableKeybinds = false;
        includes.enable = false;
      };

      plugins = {
        calculator.enable = true;
        floaty.enable = true;

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

    dsearch.enable = true;
  };

  # TODO: split this up when refactoring niri keybind/config settings
  # programs.niri.settings.binds = {
  #   "Mod+Shift+Alt+S" = {
  #     action.spawn = [
  #       "sh"
  #       "-c"
  #       "dms screenshot region --no-file --no-notify && dms ipc call floaty floatFromClipboard"
  #     ];
  #     hotkey-overlay.title = "Screenshot && Float Over Workspace";
  #   };
  # };

  stylix.targets.dank-material-shell.enable = lib.mkIf (builtins.hasAttr "stylix" config) true;
}
