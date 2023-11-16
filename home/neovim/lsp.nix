{pkgs, ...}: {
  home.packages = with pkgs; [
    gopls
    nixd
    nodePackages.intelephense
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    sqls
  ];
}
