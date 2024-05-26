{pkgs, ...}: let 
  codecompanion = pkgs.vimUtils.buildVimPlugin {
    name = "codecompletion";
    src = pkgs.fetchFromGitHub {
      owner = "olimorris";
      repo = "codecompanion";
      rev = "5f53f6f71c544f1e277cc6aba705f5843108a307";
      hash = "sha256-FZQH38E02HuRPIPAog/nWM55FuBxKp8AyrEldFkoLYk=";
    };
  };
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    codecompanion
    nvim-cmp
    cmp-buffer
    cmp-cmdline
    cmp-dap
    cmp-nvim-lsp
    cmp-path
    cmp_luasnip
  ];

  xdg.configFile = {
    "nvim/after/plugin/ai.lua".source = ./ai.lua;
    "nvim/after/plugin/completion.lua".source = ./completion.lua;
  };
}
