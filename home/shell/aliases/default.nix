let
  git = import ./git.nix;
  nix = import ./nix.nix;
  qol = import ./qol.nix;
  useful = import ./useful.nix;
in
  git // nix // qol // useful
