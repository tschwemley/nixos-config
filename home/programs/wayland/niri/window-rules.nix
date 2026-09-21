[
  # open as floating window
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
  # fix steam notification pop-up position at the center of the screen
  {
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
  # block from screencasting
  {
    window-rule = {
      _children = [
        {
          match._props = {
            app-id = "bitwarden";
            title = "^Bitwarden$";
          };
        }
        {
          match._props = {
            title = "^Extension: (Bitwarden Password Manager).*";
          };
        }
      ];

      block-out-from = "screencast";
    };
  }
]
