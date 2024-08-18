{lib, ...}: {
  options.hyprland = with lib; {
    monitors = {
      config = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "The monitor(s) to config for Hyprland";
      };

      primary = mkOption {
        type = types.str;
        default = "";
        description = "The primary monitor id (e.g. DP-1)";
      };
    };

    workspaces = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "The workspaces config for Hyprland";
    };
  };
}
