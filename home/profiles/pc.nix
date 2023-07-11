let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in {
  imports = [
    ./.
    ../programs/discord.nix
    ../programs/lazygit.nix
    ../programs/reaper.nix
    ../programs/slack.nix
    ../terminals/wezterm.nix
    git
  ];
}
