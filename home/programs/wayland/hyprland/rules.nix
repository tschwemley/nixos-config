let
  onlykey = ["float, initialTitle:OnlyKey App"];
  pavucontrol = [ "float, class:org.pulseaudio.pavucontrol" ];
  steam = [
    "float, title:^(Steam)$"
    "float, title:^(Friends List)$"
    # the next two rules fix menu focus issues
    "stayfocused, title:^()$,class:^(steam)$"
    "minsize 1 1, title:^()$,class:^(steam)$"
  ];
  zen = [ "float, title:^(Picture-in-Picture)$" ];
in
{
  wayland.windowManager.hyprland.settings = {
    layerrule = [ ];
    windowrulev2 = onlykey ++ pavucontrol ++ steam ++ zen;
  };
}
