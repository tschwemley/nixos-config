self: (_: prev: {
  inherit (self.inputs.zen-browser.packages.${prev.system}) zen-browser;
})
