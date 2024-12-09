let
  git = import ./git.nix;
  nix = import ./nix.nix;
  overrides = import ./overrides.nix;
  qol = import ./qol.nix;
in
  git // nix // overrides // qol
