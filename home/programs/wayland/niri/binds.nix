# TODO: add/test the following:
#
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

{
  # ---
  # Window Management
  # ---
  "Mod+Left".focus-column-left = { };
  "Mod+Down".focus-window-down = { };
  "Mod+Up".focus-window-up = { };
  "Mod+Right".focus-column-right = { };
  "Mod+H".focus-column-left = { };
  "Mod+J".focus-window-or-workspace-down = { };
  "Mod+K".focus-window-or-workspace-up = { };
  "Mod+L".focus-column-right = { };

  "Mod+Ctrl+Left".move-column-left = { };
  "Mod+Ctrl+Down".move-window-down = { };
  "Mod+Ctrl+Up".move-window-up = { };
  "Mod+Ctrl+Right".move-column-right = { };
  "Mod+Ctrl+H".move-column-left = { };
  "Mod+Ctrl+J".move-window-down = { };
  "Mod+Ctrl+K".move-window-up = { };
  "Mod+Ctrl+L".move-column-right = { };

  "Mod+Shift+Left".focus-monitor-left = { };
  "Mod+Shift+Down".focus-monitor-down = { };
  "Mod+Shift+Up".focus-monitor-up = { };
  "Mod+Shift+Right".focus-monitor-right = { };
  "Mod+Shift+H".focus-monitor-left = { };
  "Mod+Shift+J".focus-monitor-down = { };
  "Mod+Shift+K".focus-monitor-up = { };
  "Mod+Shift+L".focus-monitor-right = { };

  "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = { };
  "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = { };
  "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = { };
  "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = { };
  "Mod+Shift+Ctrl+H".move-column-to-monitor-left = { };
  "Mod+Shift+Ctrl+J".move-column-to-monitor-down = { };
  "Mod+Shift+Ctrl+K".move-column-to-monitor-up = { };
  "Mod+Shift+Ctrl+L".move-column-to-monitor-right = { };

  "Mod+R".switch-preset-column-width = { };
  "Mod+Shift+R".switch-preset-window-height = { };
  "Mod+Ctrl+R".reset-window-height = { };
  "Mod+F".maximize-column = { };
  "Mod+Ctrl+F".expand-column-to-available-width = { };
  "Mod+Shift+F".toggle-window-floating = { };

  "Mod+1".focus-workspace = 1;
  "Mod+2".focus-workspace = 2;
  "Mod+3".focus-workspace = 3;
  "Mod+4".focus-workspace = 4;
  "Mod+5".focus-workspace = 5;
  "Mod+6".focus-workspace = 6;
  "Mod+7".focus-workspace = 7;
  "Mod+8".focus-workspace = 8;
  "Mod+9".focus-workspace = 9;

  "Mod+Ctrl+1".move-column-to-workspace = 1;
  "Mod+Ctrl+2".move-column-to-workspace = 2;
  "Mod+Ctrl+3".move-column-to-workspace = 3;
  "Mod+Ctrl+4".move-column-to-workspace = 4;
  "Mod+Ctrl+5".move-column-to-workspace = 5;
  "Mod+Ctrl+6".move-column-to-workspace = 6;
  "Mod+Ctrl+7".move-column-to-workspace = 7;
  "Mod+Ctrl+8".move-column-to-workspace = 8;
  "Mod+Ctrl+9".move-column-to-workspace = 9;

  # ---
  #
  # ---

  "Mod+T" = {
    _props.hotkey-overlay-title = "Open a Terminal: wezterm";
    spawn = [ "wezterm" ];
  };

  "Mod+Shift+C" = {
    spawn = "wl-ocr";
  };

  "Mod+Q" = {
    _props.repeat = false;
    close-window = { };
  };

  "Mod+Shift+S".screenshot = { };

  # "Super+Alt+L".action = {
  #   spawn = "swaylock";
  #   title = "Lock the Screen: swaylock";
  # };

  # ---
  # DMS Binds
  # ---
  "Mod+Space" = {
    spawn = [
      "dms"
      "ipc"
      "call"
      "spotlight"
      "toggle"
    ];
    _props.hotkey-overlay-title = "Application Launcher";
  };

  "Mod+P" = {
    spawn = [
      "dms"
      "ipc"
      "call"
      "spotlight"
      "toggle"
    ];
    _props.hotkey-overlay-title = "Application Launcher";
  };

  "Mod+V" = {
    spawn = [
      "dms"
      "ipc"
      "call"
      "clipboard"
      "toggle"
    ];
    _props.hotkey-overlay-title = "Clipboard Manager";
  };

  "Mod+M" = {
    spawn = [
      "dms"
      "ipc"
      "call"
      "processlist"
      "focusOrToggle"
    ];
    _props.hotkey-overlay-title = "Task Manager";
  };

  "Mod+Comma" = {
    spawn = [
      "dms"
      "ipc"
      "call"
      "settings"
      "focusOrToggle"
    ];
    _props.hotkey-overlay-title = "Settings";
  };

  "Mod+N" = {
    spawn = [
      "dms"
      "ipc"
      "call"
      "notifications"
      "toggle"
    ];
    _props.hotkey-overlay-title = "Notification Center";
  };

  "Mod+Y" = {
    spawn = [
      "dms"
      "ipc"
      "call"
      "dankdash"
      "wallpaper"
    ];
    _props.hotkey-overlay-title = "Browse Wallpapers";
  };

  # # "Mod+O".action.toggle-overview = {
  # #   repeats = false;
  # # };
  #
}
