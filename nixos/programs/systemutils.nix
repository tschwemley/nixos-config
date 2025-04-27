{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    dust
    fclones
    lsof
    psmisc
    tree
    unzip
    wget
    zip
  ];
}
