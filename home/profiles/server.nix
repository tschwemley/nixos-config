{pkgs, ...}: {
  imports = [
    ./.
  ];

  home.packages = with pkgs; [mariadb];
}
