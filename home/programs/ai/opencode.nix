{ self, pkgs, ... }: {
  home.packages = [ self.inputs.llm-agents.packages.${self.lib.system pkgs}.opencode ];
}
