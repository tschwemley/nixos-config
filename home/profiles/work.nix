{ lib, pkgs, ... }:
let
  git = import ../programs/git.nix {
    inherit pkgs;
    name = "Tyler Schwemley";
    email = lib.mkForce "tschwemley@zynga.com";
  };
in
{
  imports = [
    git
    ./.
    ../programs/glow.nix
    ../programs/jira-cli.nix
    ../programs/wcalc.nix
    ../xdg/ssh/work.nix
  ];

  home = {
    username = "tschwemley";
    homeDirectory = "/Users/tschwemley";
  };

  sops.age.keyFile = "/etc/sops/age-keys.txt";
}
