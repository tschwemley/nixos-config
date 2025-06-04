self: (_: prev: {
  vimPlugins =
    prev.vimPlugins
    // self.packages.${prev.system}.extraVimPlugins;
  # TODO: validate removal okay
  # // {
  #
  # # TODO: can be removed as soon as nixpkgs has version >= 2025-04-30
  # none-ls-nvim = prev.vimUtils.buildVimPlugin {
  #   pname = "none-ls.nvim";
  #   version = "2025-04-26";
  #   src = prev.fetchFromGitHub {
  #     owner = "nvimtools";
  #     repo = "none-ls.nvim";
  #     rev = "0233f19bd645f22ca477c702a329ba7bc921b37b";
  #     sha256 = "0kaz9v45i36d35lrjpkyryb2ilb5wf0ixwgyw6lkryzzi8md69yz";
  #   };
  #   meta.homepage = "https://github.com/nvimtools/none-ls.nvim/";
  #   meta.hydraPlatforms = [];
  # };
  # };
})
