{
  self,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with self.inputs.llm-agents.packages.${lib.system pkgs}; [ pi ];
}
