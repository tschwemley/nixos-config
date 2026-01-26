{
  programs.fuzzel = {
    enable = true;

    settings = {
      colors = {
        background = "282828ff";
        text = "d4be98ff";
        match = "a9b665ff";
        selection = "504945ff";
        selection-text = "d4be98ff";
        selection-match = "a9b665ff";
        border = "7c6f64ff";
      };

      main = {
        terminal = "wezterm";
        layer = "overlay";
      };
    };
  };
}
