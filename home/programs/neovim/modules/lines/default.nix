{pkgs, ...}: let
  # NOTE: this wont be necessary once nixpkgs get an updated version of the bufferline-nvim plugin
  # (at least version 04-21-2024 [a6ad228f77c276a4324924a6899cbfad70541547])
  bufferline-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "bufferline-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "akinsho";
      repo = "bufferline.nvim";
      rev = "73540cb95f8d95aa1af3ed57713c6720c78af915";
      hash = "sha256-bHlmaNXfZTlTm/8v48FwCde9ljZFLv25efYF5355bnw=";
    };
  };
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    bufferline-nvim
    lualine-nvim
  ];

  xdg.configFile."nvim/after/plugin/lines.lua".source = ./lines.lua;
}
