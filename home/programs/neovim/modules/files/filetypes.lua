-- add any filetypes that aren't registered by default or need to be aliased to another type
vim.filetype.add({
   extension = {
      bru = "bruno",
      har = "json",
      pac = "js",
      zsh = "bash",
   },
   filename = {
      [".zshrc"] = "bash",
      [".zshenv"] = "bash",
   },
})
