let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in {
  imports = [
    ./.
    ../programs/brave.nix
    ../programs/discord.nix
    ../programs/lazygit.nix
    ../programs/reaper.nix
    ../programs/slack.nix
    ../terminals/wezterm.nix
    git
  ];

  # TODO: move this to system level or someplace more appropriate at a later date
  xdg.configFile = {
    "awesome".source = ../xdg-config/awesome;
  };
}
