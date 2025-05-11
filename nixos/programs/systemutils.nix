{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    dmidecode
    dust
    fclones
    inxi
    lsof
    pciutils
    psmisc
    tree
    unzip
    wget
    zip
  ];
}
