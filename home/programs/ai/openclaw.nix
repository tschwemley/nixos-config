{
  self,
  lib,
  pkgs,
  ...
}:
let
  inherit (self.inputs.llm-agents.packages.${lib.system pkgs}) openclaw;
in
{
  home.packages = [ openclaw ];
}
