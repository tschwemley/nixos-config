self:
(_: prev: {
  inherit (self.inputs.neovim-nightly-overlay.packages.${self.lib.system prev})
    neovim
    neovim-debug
    neovim-developer
    tree-sitter
    ;

  vimPlugins =
    prev.vimPlugins
    // self.packages.${self.lib.system prev}.extraVimPlugins
    // {
      fzf-lua = prev.vimPlugins.fzf-lua.overrideAttrs {
        checkPhase = "";
        doCheck = false;
      };
    };
})
