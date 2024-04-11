pkgs: let
  importPlugin = path: (import ./${path} pkgs);
in [
  importPlugin
  ""
]
