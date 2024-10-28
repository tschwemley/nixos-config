vimPlugins: {
  plugin = vimPlugins.rest-nvim;
  type = "lua";
  config = # lua
    ''
      require("telescope").load_extension("rest")

      vim.keymap.set("n", "rc", ":Rest cookies<cr>")
      vim.keymap.set("n", "re", ":Rest env<cr>")
      vim.keymap.set("n", "rl", ":Rest last<cr>")
      vim.keymap.set("n", "rL", ":Rest logs<cr>")
    '';
}
