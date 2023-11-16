{...}: let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in {
  imports = [
    git
    ./.
    ../programs/github.nix
    ../programs/glow.nix
    # ../programs/visidata.nix
    ../programs/wezterm
    ../programs/wiki-tui.nix
    ../programs/zk
  ];
}
