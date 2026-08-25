{ pkgs, ... }:
{
  imports = [
    ./zen-browser
  ];

  home = {
    packages = with pkgs; [
      brave
      lynx
      mullvad-browser
      tor-browser
    ];

    # Env variables are here  instead of ./zen-browser because mullvad-browser also uses them
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";
    };
  };
}
