[
  {
    window-rule = {
      _children = [
        { match._props.app-id = "mpv"; }
        {
          match._props = {
            app-id = "steam";
            title = "Friends List";
          };
        }
        {
          match._props = {
            app-id = "steam";
            title = "Steam Settings";
          };
        }
        {
          match._props = {
            app-id = "zen-beta$";
            title = "^Picture-in-Picture$";
          };
        }
        {
          match._props.title = "Select what to share";
        }
      ];

      open-floating = true;
    };
  }
  {
    # fix steam notification pop-up position at the center of the screen
    window-rule = {
      _children = [
        {
          match._props = {
            app-id = "steam";
            title = "^notificationtoasts_\\d+_desktop$";
          };
        }
      ];

      default-floating-position._props = {
        x = 10;
        y = 10;
        relative-to = "bottom-right";
      };

      open-focused = false;
    };
  }

  # TODO: determine if the rule below is pertintent. If so re-add; otherwise delete.

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
