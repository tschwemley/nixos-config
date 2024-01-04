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
    ../programs/httpie.nix
    ../programs/taskwarrior.nix
    ../programs/wiki-tui.nix
    # BUG: currently failing tests upstream
    # ../programs/visidata.nix
    ../programs/zk
    ../shell/direnv.nix
    ../shell/starship.nix
  ];
}
