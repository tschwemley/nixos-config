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
    ../programs/glow.nix
    ../programs/httpie.nix
    ../programs/taskwarrior.nix
    ../programs/wiki-tui.nix
    ../programs/zk
    ../shell/direnv.nix
    ../shell/starship.nix
  ];
}
