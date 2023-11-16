{pkgs, ...}: {
  home.packages = with pkgs; [sonic-pi];

  # TODO: add nvim plugin https://github.com/magicmonty/sonicpi.nvim
}
