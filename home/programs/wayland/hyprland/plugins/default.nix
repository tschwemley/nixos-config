# { pkgs, ... }:
{
  imports = [ ./hyprlock.nix ];

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  # wayland.windowManager.hyprland.plugins = with pkgs; [hyprlandPlugins.hy3];
  wayland.windowManager.hyprland.settings = {
    # extraConfig = ''
    #     plugin {
    #       easymotion {
    #         #font size of the text
    #         textsize=20
    #
    #         #color of the text, takes standard hyprland color format
    #         # textcolor=rgba(000000ff)
    #
    #         #background color of the label box. alpha is respected
    #         bgcolor=rgba(000000ff)
    #
    #         #font to use for the label. This is passed directly to the pango font description
    #         textfont=Sans
    #
    #         #padding around th<D-z>e text (inside the label box) size in pixels, adjusted for
    #         #monitor scaling. This is the same format as hyprland's gapsin/gapsout workspace layout rule
    #         #example: textpadding=2 5 5 2 (spaces not commas)
    #         textpadding=0
    #
    #         #size of the border around the label box. A border size of zero disables border rendering.
    #         bordersize=0
    #
    #         #color of the border. takes the same format as hyprland's border (so it can be a gradient)
    #         # bordercolor=rgba(ffffffff)
    #
    #         #rounded corners? Same as hyprland's 'decoration:rounding' config
    #         rounding=0
    #
    #         #which keys to use for labeling windows
    #         motionkeys=abcdefghijklmnopqrstuvwxyz1234567890
    #       }
    #   }
    # '';
    #
    # plugins = [
    #   pkgs.hypreasymotion
    #   # "/home/schwem/libhyprscroller.so"
    # ];
    #
  };
}
