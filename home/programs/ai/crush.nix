{
  self,
  config,
  pkgs,
  ...
}:
let
  lib = self.lib;
in
{
  imports = [
    self.inputs.charm.homeModules.crush
  ];

  programs.crush = {
    enable = true;

    settings = {
      lsp = {
        go = {
          command = lib.getExe pkgs.gopls;
        };
        nix = {
          command = lib.getExe pkgs.nil;
        };
      };

      # options = {
      #   context_paths = [ "/home/schwem/nixos-config/flake.nix" ];
      #   tui = {
      #     compact_mode = true;
      #   };
      #   debug = false;
      # };

      # permissions = {
      #   allowed_tools = [
      #     "glob"
      #     "grep"
      #     "ls"
      #     "lsp_diagnostics"
      #     "lsp_references"
      #     "todos"
      #     "view"
      #   ];
      # };

      providers = {
        openrouter = {
          name = "openrouter";
          id = "openrouter";
          api_key = "$(cat ${config.sops.secrets.crush_openrouter_api_key.path})";
          models = [

          ];
        };
      };
    };
  };

  sops.secrets.crush_openrouter_api_key = {
    key = "openrouter_api_key_crush";
    mode = "0400";
    sopsFile = self.lib.secret "home" "ai.yaml";
  };
}
