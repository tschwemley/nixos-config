{
  wayland.windowManager.hyprland.settings = {
    layerrule = [ ];
    windowrulev2 = [
      # android
      "float, initialClass:Emulator"

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
      "float, initialClass:steam"

      # zen
      "float, title:^(Picture-in-Picture)$"
      "float, title:^(Developer Tools)"
    ];
  };
}
