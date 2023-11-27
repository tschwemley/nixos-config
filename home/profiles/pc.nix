{...}: let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in {
  imports = [
    git
    ./.
    ../programs/buku.nix
    ../programs/github.nix
    ../programs/glow.nix
    # BUG: currently failing tests upstream
    # ../programs/visidata.nix
    ../programs/wezterm
    ../programs/wiki-tui.nix
    ../programs/zk
  ];
}
