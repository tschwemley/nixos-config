vimPlugins: {
  plugin = vimPlugins.rest-nvim;
  type = "lua";
  config =
    # lua
    ''
      require("telescope").load_extension("rest")

      vim.keymap.set("n", "<leader>rc", ":Rest cookies<cr>")
      vim.keymap.set("n", "<leader>re", ":Rest env<cr>")
      vim.keymap.set("n", "<leader>rl", ":Rest last<cr>")
      vim.keymap.set("n", "<leader>rL", ":Rest logs<cr>")
    '';
}
