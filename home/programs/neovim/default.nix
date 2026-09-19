{
  self,
  lib,
  ...
}:
{
  imports = [
    # ./env.nix
    ./formatters.nix
    ./lsp.nix
    ./plugins.nix
    ./treesitter.nix
  ];

  programs.neovim = {
    enable = true;

    defaultEditor = lib.mkDefault true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = false;
  };

  xdg = {
    configFile."nvim".source = ./config;
    dataFile."nvim/snippets".source = ./snippets;

    # TODO: fix desktop entry
    # desktopEntries.nvim-terminal =
    #   with lib;
    #   mkIf (isPC nixosConfig.networking.hostName) {
    #     name = "Neovim (Terminal)";
    #     genericName = "Text Editor";
    #     exec = "wezterm -- nvim %F";
    #     terminal = true;
    #
    #     categories = [
    #       "Utility"
    #       "TextEditor"
    #     ];
    #
    #     mimeType = [
    #       "application/xml"
    #       "text/xml"
    #     ];
    #   };
  };
}
