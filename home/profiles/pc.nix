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
    ../terminals/wezterm.nix
    git
  ];
}
