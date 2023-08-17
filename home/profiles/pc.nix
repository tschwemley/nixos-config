{inputs, ...}: {
  imports = [
    ./.
    ../programs/brave.nix
    ../programs/discord.nix
    ../programs/firefox.nix
    ../programs/reaper.nix
    ../programs/rbw.nix
    ../programs/rofi.nix
    ../programs/slack.nix
    ../programs/sonic-pi.nix
    ../programs/tigervnc.nix
    ../programs/zk
    ../terminals/wezterm.nix
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland.enable = true;

  # TODO: move this to system level or someplace more appropriate at a later date
  # xdg.configFile = {
  #   "awesome/rc.lua".source = ../xdg-config/awesome/rc.lua;
  # };
}
