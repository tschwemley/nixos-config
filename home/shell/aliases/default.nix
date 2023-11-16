let
  git = import ./git.nix;
  nix = import ./nix.nix;
  qol = import ./qol.nix;
in
  with git nix qol; {}
