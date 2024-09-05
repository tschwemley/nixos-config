let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tschwemley@zynga.com";
  };
in
{
  imports = [
    git
    ./.
    ../programs/glow.nix
    ../programs/jira-cli.nix
    ../programs/wcalc.nix
  ];

  home = {
    username = "tschwemley";
    homeDirectory = "/Users/tschwemley";
  };
}
