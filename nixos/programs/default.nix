{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    age
    curl
    dust
    git
    gnupg
    ogen
    jq
    lsof
    pinentry
    pwgen
    ripgrep
    rsync
    sops
    tree
    unzip
    wget
    zip
  ];
}
