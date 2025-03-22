{pkgs, ...}: {
  home.packages = [
    pkgs.nemo
    # TODO: REMOVE/REFACTOR AFTER TESTING
    pkgs.krusader
    pkgs.kdePackages.konqueror
  ];
}
