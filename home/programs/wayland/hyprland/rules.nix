let
  pavucontrolRules = [ "float, class:org.pulseaudio.pavucontrol" ];
  steamRules = [
    "float, title:^(Steam)$"
    "float, title:^(Friends List)$"
    # the next two rules fix menu focus issues
    "stayfocused, title:^()$,class:^(steam)$"
    "minsize 1 1, title:^()$,class:^(steam)$"
  ];
in
{
  wayland.windowManager.hyprland.settings = {
    layerrule = [ ];
    windowrulev2 = pavucontrolRules ++ steamRules;
  };
}
