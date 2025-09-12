self:
(_: prev: {
  vimPlugins =
    prev.vimPlugins
    // self.packages.${prev.system}.extraVimPlugins
    // {
      fzf-lua = prev.vimPlugins.fzf-lua.overrideAttrs {
        checkPhase = "";
        doCheck = false;
      };
    };
})
