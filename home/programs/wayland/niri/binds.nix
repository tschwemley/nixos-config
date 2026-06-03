{
  # ---
  # Window Management
  # ---
  "Mod+Left".action.focus-column-left = { };
  "Mod+Down".action.focus-window-down = { };
  "Mod+Up".action.focus-window-up = { };
  "Mod+Right".action.focus-column-right = { };
  "Mod+H".action.focus-column-left = { };
  "Mod+J".action.focus-window-down = { };
  "Mod+K".action.focus-window-up = { };
  "Mod+L".action.focus-column-right = { };

  "Mod+Ctrl+Left".action.move-column-left = { };
  "Mod+Ctrl+Down".action.move-window-down = { };
  "Mod+Ctrl+Up".action.move-window-up = { };
  "Mod+Ctrl+Right".action.move-column-right = { };
  "Mod+Ctrl+H".action.move-column-left = { };
  "Mod+Ctrl+J".action.move-window-down = { };
  "Mod+Ctrl+K".action.move-window-up = { };
  "Mod+Ctrl+L".action.move-column-right = { };

  "Mod+Shift+Left".action.focus-monitor-left = { };
  "Mod+Shift+Down".action.focus-monitor-down = { };
  "Mod+Shift+Up".action.focus-monitor-up = { };
  "Mod+Shift+Right".action.focus-monitor-right = { };
  "Mod+Shift+H".action.focus-monitor-left = { };
  "Mod+Shift+J".action.focus-monitor-down = { };
  "Mod+Shift+K".action.focus-monitor-up = { };
  "Mod+Shift+L".action.focus-monitor-right = { };

  "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = { };
  "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = { };
  "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = { };
  "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = { };
  "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = { };
  "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = { };
  "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = { };
  "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = { };

  "Mod+R".action.switch-preset-column-width = { };
  "Mod+Shift+R".action.switch-preset-window-height = { };
  "Mod+Ctrl+R".action.reset-window-height = { };
  "Mod+F".action.maximize-column = { };
  "Mod+Ctrl+F".action.expand-column-to-available-width = { };
  "Mod+Shift+F".action.toggle-window-floating = { };

  "Mod+1".action.focus-workspace = 1;
  "Mod+2".action.focus-workspace = 2;
  "Mod+3".action.focus-workspace = 3;
  "Mod+4".action.focus-workspace = 4;
  "Mod+5".action.focus-workspace = 5;
  "Mod+6".action.focus-workspace = 6;
  "Mod+7".action.focus-workspace = 7;
  "Mod+8".action.focus-workspace = 8;
  "Mod+9".action.focus-workspace = 9;

  "Mod+Ctrl+1".action.move-column-to-workspace = 1;
  "Mod+Ctrl+2".action.move-column-to-workspace = 2;
  "Mod+Ctrl+3".action.move-column-to-workspace = 3;
  "Mod+Ctrl+4".action.move-column-to-workspace = 4;
  "Mod+Ctrl+5".action.move-column-to-workspace = 5;
  "Mod+Ctrl+6".action.move-column-to-workspace = 6;
  "Mod+Ctrl+7".action.move-column-to-workspace = 7;
  "Mod+Ctrl+8".action.move-column-to-workspace = 8;
  "Mod+Ctrl+9".action.move-column-to-workspace = 9;

  # ---
  #
  # ---
  "Mod+T" = {
    action.spawn = "wezterm";
    hotkey-overlay.title = "Open a Terminal: wezterm";
  };

  # "Mod+O".action.toggle-overview = {
  #   repeats = false;
  # };

  "Mod+Shift+C" = {
    action.spawn = "wl-ocr";
  };

  "Mod+Q" = {
    action.close-window = { };
    repeat = false;
  };

  "Mod+Shift+S".action.screenshot = { };

  # "Mod+P".action.spawn = ["fuzzel"];
  #   title = "Run an Application: fuzzel";
  # };

  # "Super+Alt+L".action = {
  #   spawn = "swaylock";
  #   title = "Lock the Screen: swaylock";
  # };

  # ---
  # DMS Binds
  # ---
  "Mod+Space" = {
    action.spawn = [
      "dms"
      "ipc"
      "call"
      "spotlight"
      "toggle"
    ];
    hotkey-overlay.title = "Application Launcher";
  };

  "Mod+P" = {
    action.spawn = [
      "dms"
      "ipc"
      "call"
      "spotlight"
      "toggle"
    ];
    hotkey-overlay.title = "Application Launcher";
  };

  "Mod+V" = {
    action.spawn = [
      "dms"
      "ipc"
      "call"
      "clipboard"
      "toggle"
    ];
    hotkey-overlay.title = "Clipboard Manager";
  };

  "Mod+M" = {
    action.spawn = [
      "dms"
      "ipc"
      "call"
      "processlist"
      "focusOrToggle"
    ];
    hotkey-overlay.title = "Task Manager";
  };

  "Mod+Comma" = {
    action.spawn = [
      "dms"
      "ipc"
      "call"
      "settings"
      "focusOrToggle"
    ];
    hotkey-overlay.title = "Settings";
  };

  "Mod+N" = {
    action.spawn = [
      "dms"
      "ipc"
      "call"
      "notifications"
      "toggle"
    ];
    hotkey-overlay.title = "Notification Center";
  };

  "Mod+Y" = {
    action.spawn = [
      "dms"
      "ipc"
      "call"
      "dankdash"
      "wallpaper"
    ];
    hotkey-overlay.title = "Browse Wallpapers";
  };
}
