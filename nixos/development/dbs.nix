{pkgs, ...}: {
    environment.systemPackages = [pkgs.mariadb];
}
