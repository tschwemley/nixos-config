{
  wayland.windowManager.hyprland.settings = {
    layerrule = [];
    windowrulev2 = [
      # bluetooth
      "float, initialClass:.blueman-manager-wrapped"

      # desktop
      "float, pin, initialClass:com.schwem.gtk4-widgets.statusbar"

      # discord
      "float, class:WebCord"

      # input leap
      "float, initialClass:io.github.input_leap.InputLeap"

      # pavucontrol
      "float, class:org.pulseaudio.pavucontrol"

      # reaper
      "stayfocused, minsize 1 1, title:^VST.*$, class:^(REAPER)$"

      # steam
      "float, title:^(Steam)$"
      "float, title:^(Friends List)$"
      "stayfocused, minsize 1 1, title:^()$, class:^(steam)$" # fixes steam menu focus issues

      # zen
      "float, title:^(Picture-in-Picture)$"
    ];
  };
}
