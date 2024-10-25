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
    homeDirectory = "/Users/tschwemley";
    username = "tschwemley";

    packages = with pkgs; [
      nodejs
    ];
  };

  sops.age.keyFile = "/etc/sops/age-keys.txt";
}
