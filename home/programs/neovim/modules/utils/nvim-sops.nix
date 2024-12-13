vimPlugins: {
  plugin = vimPlugins.nvim-sops;
  type = "lua";
  config =
    /*
    lua
    */
    ''
      require('nvim_sops').setup({
        defaults = {
          ageKeyFile = "/etc/sops/age-keys.txt",
        },
      })
    '';
}
