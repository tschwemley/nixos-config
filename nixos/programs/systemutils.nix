{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    dmidecode
    dust
    fclones
    inxi
    lsof
    parallel
    pciutils
    psmisc
    tree
    unzip
    wget
    zip
  ];
}
