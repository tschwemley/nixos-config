{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    dust
    jdupes
    lsof
    psmisc
    tree
    unzip
    wget
    zip
  ];
}
