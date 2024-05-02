let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "";
  };
in {
  imports = [
    git
    ./.
    ../programs/glow.nix
    ../programs/wcalc.nix
  ];

  home = {
    username = "tschwemley";
    homeDirectory = "/Users/tschwemley";
  };
}
