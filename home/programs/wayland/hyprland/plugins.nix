{pkgs, ...}: let
  hyprland-easymotion = with pkgs;
    hyprlandPlugins.mkHyprlandPlugin hyprland {
      pluginName = "hyprland-easymotion";
      version = "main";

      src = fetchFromGitHub {
        owner = "zakk4223";
        repo = "hyprland-easymotion";
        rev = "main";
        hash = "sha256-lyv0qM6R0BNBu1B4jMw+mn6K8NYTbr/tmjscfL7Uf78=";
      };

      nativeBuildInputs = [cmake];

      dontStrip = true;
    };
in {
  wayland.windowManager.hyprland.plugins = [
    hyprland-easymotion
  ];
}
