{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mariadb
    sqlite-interactive
  ];
}
