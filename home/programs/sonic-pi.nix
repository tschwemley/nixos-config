{pkgs, ...}: {
  home.packages = with pkgs; [
    pipewire
    sonic-pi
    supercollider
  ];

  # TODO: add nvim plugin https://github.com/magicmonty/sonicpi.nvim
}
