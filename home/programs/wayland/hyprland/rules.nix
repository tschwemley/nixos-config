{
  wayland.windowManager.hyprland.settings = {
    layerrule = [];
    windowrulev2 = [
      "float, title:^(Steam)$"
      # the next two rules fix menu focus issues
      "stayfocused, title:^()$,class:^(steam)$"
      "minsize 1 1, title:^()$,class:^(steam)$"
    ];
  };
}
