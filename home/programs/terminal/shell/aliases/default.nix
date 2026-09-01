let
  nix = import ./nix.nix;
  overrides = import ./overrides.nix;
  qol = import ./qol.nix;
in
  nix // overrides // qol
