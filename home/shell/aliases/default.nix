let
  git = import ./git.nix;
  nix = import ./nix.nix;
in
with git nix; {}
