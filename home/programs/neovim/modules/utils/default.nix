{
  lib,
  pkgs,
  ...
}: {
  imports = [./boole.nix];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    # TODO: revisit navbuddy when time... looks interesting
    # navbuddy # old config: navbuddy = import ./navbuddy.nix pkgs.vimPlugins;

    direnv-vim
    dressing-nvim
    leap-nvim
    nnn-vim
    nvim-ufo
    plenary-nvim # most plugins install this as a dependency; I'm including for it's log method
    vim-abolish
    vim-speeddating
    # vim-surround
    vim-startuptime

    (import ./colorizer.nix pkgs.vimPlugins)
  ];

  xdg.configFile."nvim/after/plugin/utils.lua".text = ''
    ${lib.readFile ./leap.lua}
    ${lib.readFile ./nnn.lua}
    ${lib.readFile ./ufo.lua}
  '';
}
