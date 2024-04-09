{pkgs, ...}: {
  home.packages = with pkgs; [
    sonic-pi
    supercollider
  ];

  # TODO: add nvim plugin https://github.com/magicmonty/sonicpi.nvim
}
