let
  git = import ./git.nix;
  nix = import ./nix.nix;
  qol = import ./qol.nix;
in
git // nix // qol
