self:
(_: prev: {
  inherit (self.inputs.zen-browser.packages.${self.lib.system prev}) zen-browser;
})
