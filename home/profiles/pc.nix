let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in {
  imports = [
    ./.
    ../programs/brave.nix
    ../programs/lazygit.nix
    ../programs/nnn.nix
    ../programs/reaper.nix
    #../programs/rustdesk.nix
    ../terminals/wezterm.nix
    ../window-managers
    git
  ];
}
