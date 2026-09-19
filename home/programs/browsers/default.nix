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
      ungoogled-chromium

      # TODO: this is in beta on linux now via flatpak, however nixpkgs only contains the darwin
      # vesrion still... Create a derivation for the beta
      # orion-browser
    ];

    # Env variables are here  instead of ./zen-browser because mullvad-browser also uses them
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";
    };
  };
}
