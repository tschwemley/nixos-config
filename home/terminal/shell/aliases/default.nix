lib: let
  nix = import ./nix.nix lib;
  overrides = import ./overrides.nix;
  qol = import ./qol.nix;
in
  nix // overrides // qol
