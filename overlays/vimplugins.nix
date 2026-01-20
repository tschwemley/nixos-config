self:
(_: prev: {
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
