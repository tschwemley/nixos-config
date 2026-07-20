[
  # basslocker
  {
    matches = [
      {
        app-id = "Bass Locker";
      }
    ];

    open-floating = true;
  }
  # fix steam notification pop up positioning at the center of the screen
  {
    matches = [
      {
        app-id = "steam";
        title = "^notificationtoasts_\\d+_desktop$";
      }
    ];

    open-focused = false;

    default-floating-position = {
      x = 10;
      y = 10;
      relative-to = "bottom-right";
    };
  }

  # float zen pip
  {
    matches = [
      {
        app-id = "zen-beta$";
        title = "^Picture-in-Picture$";
      }
    ];
    open-floating = true;
  }

  # rematch
  {
    matches = [
      {
        app-id = "steam_app_2138720";
      }
    ];
    open-fullscreen = true;
  }

  # screen share dialog
  {
    matches = [
      {
        title = "Select what to share";
      }
    ];
    open-floating = true;
  }

  # # Work around wezterm initial configure bug by setting an empty default-column-width.
  # {
  #   # This regular expression is intentionally made as specific as possible,
  #   # since this is the default config, and we want no false positives.
  #   # You can get away with just app-id = "wezterm" if you want.
  #   matches = [
  #     {
  #       app-id = "^org\\.wezfurlong\\.wezterm$";
  #     }
  #   ];
  #   default-column-width = { };
  # }
]
