{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      telescope-frecency-nvim

      # telescope extensions
      telescope-manix
    ];

    extraPackages = [pkgs.fd];
  };

  xdg.configFile."nvim/after/plugin/telescope.lua".source = ./telescope.lua;
}
